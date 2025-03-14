{config, ...}: {
  environment.variables = {
    SYSTEMD_PAGERSECURE = "true";

    # Some programs like `nh` use the FLAKE env var to determine the flake path
    FLAKE = config.garden.environment.flakePath;
    NH_FLAKE = config.garden.environment.flakePath;
  };
}
