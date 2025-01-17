{
  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
    variables = {
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      PYENV_ROOT = "$XDG_DATA_HOME/pyenv";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";

      ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
      XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
      TLDR_CACHE_DIR = "$XDG_CACHE_HOME/tldr";
      WINEPREFIX = "$XDG_DATA_HOME/wine";
    };
  };
}
