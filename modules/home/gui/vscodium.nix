{pkgs, ...}: let
  jonathanharty.gruvbox-material-icon-theme = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "gruvbox-material-icon-theme";
      publisher = "JonathanHarty";
      version = "1.1.5";
      hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
    };
  };
  # sainnhe.gruvbox-material = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  #   mktplcRef = {
  #     name = "gruvbox-material";
  #     publisher = "sainnhe";
  #     version = "6.5.2";
  #     hash = "sha256-D+SZEQQwjZeuyENOYBJGn8tqS3cJiWbEkmEqhNRY/i4=";
  #   };
  # };
in {
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium;
    # obecne
    package =
      pkgs.vscodium.override
      {
        commandLineArgs = [
          "--ozone-platform-hint=auto"
          "--ozone-platform=wayland"
        ];
      };
    extensions = with pkgs.vscode-extensions; [
      # nix language
      bbenoist.nix
      # nix-shell suport
      arrterian.nix-env-selector
      # python
      ms-python.python
      # C/C++
      ms-vscode.cpptools
      # OCaml
      ocamllabs.ocaml-platform
      # Color theme
      jdinhlife.gruvbox
      # sainnhe.gruvbox-material
      jonathanharty.gruvbox-material-icon-theme
      # nvim
      asvetliakov.vscode-neovim
      # alejandra
      kamadorueda.alejandra
    ];
    userSettings = {
      "update.mode" = "none";
      "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
      "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
      "keyboard.dispatch" = "keyCode"; # needed for respecting caps:escape swap

      "window.menuBarVisibility" = "toggle";
      "editor.fontFamily" = "'FiraCode Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font', 'SymbolsNerdFont'";
      "editor.fontSize" = 16;
      "workbench.colorTheme" = "Gruvbox Dark Hard";
      "workbench.iconTheme" = "gruvbox-material-icon-theme";
      "material-icon-theme.folders.theme" = "classic";
      "vsicons.dontShowNewVersionMessage" = true;
      "explorer.confirmDragAndDrop" = false;
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = true;
      "workbench.startupEditor" = "none";

      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.formatOnPaste" = true;

      "workbench.layoutControl.type" = "menu";
      "workbench.editor.limit.enabled" = true;
      "workbench.editor.limit.value" = 10;
      "workbench.editor.limit.perEditorGroup" = true;
      "workbench.editor.showTabs" = "multiple";
      #"files.autoSave" = "onWindowChange";
      "explorer.openEditors.visible" = 0;
      "breadcrumbs.enabled" = false;
      "editor.renderControlCharacters" = false;
      #"workbench.activityBar.location" = "hidden";
      "workbench.statusBar.visible" = true;
      "editor.scrollbar.verticalScrollbarSize" = 5;
      "editor.scrollbar.horizontalScrollbarSize" = 5;
      #"editor.scrollbar.vertical" = "hidden";
      #"editor.scrollbar.horizontal" = "hidden";
      "workbench.layoutControl.enabled" = false;

      "editor.mouseWheelZoom" = true;

      # needed for nvim
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    };
    # Keybindings
    keybindings = [
      {
        key = "ctrl+q";
        command = "editor.action.commentLine";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "ctrl+s";
        command = "workbench.action.files.saveFiles";
      }
    ];
  };
}
