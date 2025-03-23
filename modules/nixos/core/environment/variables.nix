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
      # desktop
      KDEHOME = "$XDG_CONFIG_HOME/kde";
      XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
      ERRFILE = "$XDG_CACHE_HOME/X11/xsession-errors";
      WINEPREFIX = "$XDG_DATA_HOME/wine";
      GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";

      # programs
      GNUPGHOME = "$XDG_DATA_HOME/gnupg";
      LESSHISTFILE = "$XDG_DATA_HOME/less/history";
      CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv";
      STEPPATH = "$XDG_DATA_HOME/step";
      WAKATIME_HOME = "$XDG_CONFIG_HOME/wakatime";
      INPUTRC = "$XDG_CONFIG_HOME/readline/inputrc";
      PLATFORMIO_CORE_DIR = "$XDG_DATA_HOME/platformio";
      DOTNET_CLI_HOME = "$XDG_DATA_HOME/dotnet";
      MPLAYER_HOME = "$XDG_CONFIG_HOME/mplayer";
      SQLITE_HISTORY = "$XDG_CACHE_HOME/sqlite_history";
      TLDR_CACHE_DIR = "$XDG_CACHE_HOME/tldr";

      # programming
      ANDROID_HOME = "$XDG_DATA_HOME/android";
      ANDROID_USER_HOME = "$XDG_DATA_HOME/android";
      GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
      IPYTHONDIR = "$XDG_CONFIG_HOME/ipython";
      JUPYTER_CONFIG_DIR = "$XDG_CONFIG_HOME/jupyter";
      GOPATH = "$XDG_DATA_HOME/go";
      M2_HOME = "$XDG_DATA_HOME/m2";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
      STACK_ROOT = "$XDG_DATA_HOME/stack";
      STACK_XDG = "1";
      NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
      NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
      NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
      NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/config";
      PYENV_ROOT = "$XDG_DATA_HOME/pyenv";
    };
  };
}

