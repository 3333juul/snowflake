{
  programs.nvf.settings.vim = {
    languages = {
      enableExtraDiagnostics = true;
      enableFormat = true;
      enableLSP = true;
      enableTreesitter = true;

      bash.enable = true;
      lua.enable = true;
      nix.enable = true;
      python.enable = true;
      rust = {
        enable = false;
        crates.enable = false;
      };
      markdown.enable = true;
    };
  };
}
