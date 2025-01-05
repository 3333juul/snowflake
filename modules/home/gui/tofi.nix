{ pkgs, ... }:
{
  programs.tofi = {
    enable = true;
    settings = {
        # Fonts
        font = "Terminess Nerd Font";
        font-size = 14;
        hint-font = true;

        # Text theming
        text-color = "#ebdbb2";
        prompt-background = "#00000000";
        prompt-background-padding = 0;
        prompt-background-corner-radius = 0;
        placeholder-color = "#FFFFFFA8";
        placeholder-background = "#00000000";
        placeholder-background-padding = 0;
        placeholder-background-corner-radius = 0;
        input-background = "#00000000";
        input-background-padding = 0;
        input-background-corner-radius = 0;
        default-result-background = "#00000000";
        default-result-background-padding = 0;
        default-result-background-corner-radius = 0;
        selection-color = "#000000";
        selection-background = "#98971a";
        selection-background-padding = "0,-1";
        selection-background-corner-radius = 0;
        selection-match-color = "#00000000";

        # Text cursor theme
        text-cursor-style = "bar";
        text-cursor-corner-radius = 0;

        # Text layout
        prompt-text = "run: ";
        prompt-padding = 0;
        num-results = 0;
        result-spacing = 0;
        horizontal = false;
        min-input-width = 0;

        # Window theming
        width = 600;
        height = 450;
        background-color = "#282828E6";
        outline-width = 0;
        outline-color = "#080800";
        border-width = 1;
        border-color = "#ebdbb2";
        corner-radius = 0;
        padding-top = 8;
        padding-bottom = 8;
        padding-left = 8;
        padding-right = 8;
        clip-to-padding = true;
        scale = true;

        # Window positioning
        anchor = "center";
        exclusive-zone = -1;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;

        # Behaviour
        hide-cursor = false;
        text-cursor = false;
        history = true;
        require-match = true;
        auto-accept-single = false;
        hide-input = false;
        hidden-character = "*";
        drun-launch = false;
        terminal = "kitty";
        late-keyboard-init = false;
        multi-instance = false;
        ascii-input = false;
    };
  };
}