// Import config
import { widgetConfigs, basePath } from './collageconfig.js';

import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import GdkPixbuf from "gi://GdkPixbuf";
import Gdk from "gi://Gdk?version=3.0";

let currentImageIndices = widgetConfigs.map(() => 0);

const setImageDimensions = (imageConfig, element, button) => {
  if (!imageConfig.path) {
    console.error("Invalid image path:", imageConfig.path);
    return;
  }

  const fullPath = basePath + imageConfig.path;
  const pixbuf = GdkPixbuf.Pixbuf.new_from_file(fullPath);
  const width = pixbuf.get_width() * (imageConfig.sizePercentage / 100);
  const height = pixbuf.get_height() * (imageConfig.sizePercentage / 100);
  element.css = `min-width: ${width}px;
                 min-height: ${height}px; 
                 border-radius: 1.5rem;
                 background-image: url('${fullPath}');
                 background-size: cover;`;
  button.css = `background-color: transparent;
                border: none;
                border-radius: 1.5rem;
                box-shadow: none;
                min-width: ${width}px;
                min-height: ${height}px;`;
};

const createWidget = (config, index) => {
  const shadowBox = Widget.Box({
    hpack: "fill",
    vpack: "fill",
    vertical: true,
    css: `background-color: transparent;
          border: none;
          border-radius: 1.5rem;
          margin: 15px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);`
  });

  const backgroundBox = Widget.Box({
    hpack: "fill",
    vpack: "fill",
    vertical: true,
  });

  const invisibleButton = Widget.Button({
    onClicked: () => {
      currentImageIndices[index] = (currentImageIndices[index] + 1) % config.images.length;
      console.log(`Changing image to: ${config.images[currentImageIndices[index]].path}`);
      setImageDimensions(config.images[currentImageIndices[index]], backgroundBox, invisibleButton);
    },
    onSecondaryClick: () => {
      currentImageIndices[index] = (currentImageIndices[index] - 1 + config.images.length) % config.images.length;
      console.log(`Changing image to: ${config.images[currentImageIndices[index]].path}`);
      setImageDimensions(config.images[currentImageIndices[index]], backgroundBox, invisibleButton);
      return true; // Prevent default context menu
    },
    onMiddleClick: () => {
      const fullPath = basePath + config.images[currentImageIndices[index]].path;
      imports.gi.GLib.spawn_command_line_async(`xdg-open ${fullPath}`);
    },
  });

  backgroundBox.children = [invisibleButton];

  setImageDimensions(config.images[currentImageIndices[index]], backgroundBox, invisibleButton);

  shadowBox.children = [backgroundBox];

  return Widget.Window({
    name: `window${index}`,
    layer: "bottom",
    anchor: ['top', 'left'],
    css: `background-color:transparent;`,
    margins: config.margins,
    child: shadowBox,
    gdkmonitor: config.monitor
  });
};

const windows = widgetConfigs.map((config, index) => createWidget(config, index));

App.config({
  windows: windows,
});

const display = Gdk.Display.get_default();

function getGdkMonitorFromName(name) {
  const screen = display.get_default_screen();
  for (let i = 0; i < display.get_n_monitors(); ++i) {
    if (screen.get_monitor_plug_name(i) === name) {
      return display.get_monitor(i);
    }
  }
  return undefined;
}

// Hook to hide windows when workspace changes
windows.forEach((window, index) => {
  const updateWindowVisibilityAndMonitor = (self) => {
    setTimeout(() => {
      const activeWorkspaces = Hyprland.monitors.map(monitor => monitor.activeWorkspace.id);
      self.visible = activeWorkspaces.includes(widgetConfigs[index].workspace);

      // Update monitor
      const workspaceMonitor = Hyprland.monitors.find(monitor => monitor.activeWorkspace.id === widgetConfigs[index].workspace);
      if (workspaceMonitor) {
        const gdkMonitor = getGdkMonitorFromName(workspaceMonitor.name);
        self.gdkmonitor = gdkMonitor;
      }
    }, 5); // 10ms delay
  };

  // Hook for workspace change
  window.hook(Hyprland.active.workspace, updateWindowVisibilityAndMonitor);

  // Hook for renaming workspace (does the same update as workspace change)
  window.hook(Hyprland, (self, eventName, data) => {
    if (eventName === "renameworkspace") {
      const [renameId, newName] = data.split(",");

      // Hide widgets if the new name is "OVERVIEW"
      if (newName === "OVERVIEW") {
        self.visible = false;
      } else {
        updateWindowVisibilityAndMonitor(self); // Otherwise, update visibility normally
      }
    }
  }, "event");
});



