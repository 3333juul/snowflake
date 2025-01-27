{
  nixpkgs.config = {
    # Allow packages that aren't FOSS
    allowUnfree = true;

    # A funny little hack to make sure that *everything* is permitted
    allowUnfreePredicate = _: true;

    # Don't allow broken packages
    allowBroken = false;
    # But occasionally we need to install some anyway so we can predicated those
    # these are usually packages like electron
    permittedInsecurePackages = [];

    # Allow packages that are not supported by my system
    allowUnsupportedSystem = true;

    # Aliases for packages
    allowAliases = true;

    # Warn about packages without maintainers.
    # Good for knowing which packages might be very out of date or broken
    #showDerivationWarnings = ["maintainerless"];

    # Overlays
    #overlays = [
    #  inputs.nur.overlay
    #];
  };
}
