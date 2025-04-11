{
  pkgs,
  config,
  ...
}: let
  inherit (config.garden.environment) flakePath;
in {
  environment.systemPackages = let
    nix-option = pkgs.writeShellScriptBin "nix-option" ''
      JSON=false
      HOSTNAME=$(hostname)

      while [[ $# -gt 0 ]]; do
        case "$1" in
          -j|--json) JSON=true ;;
          -h|--host) HOSTNAME="$2"; shift ;;
          *) OPTIONS="$1" ;;
        esac
        shift
      done

      if ${
        if pkgs.stdenv.hostPlatform.isDarwin
        then "true"
        else "false"
      }; then
        CLASS="darwinConfigurations"
      else
        CLASS="nixosConfigurations"
      fi

      if $JSON; then
        nix eval --json "${flakePath}#$CLASS.$HOSTNAME.config.$OPTIONS" | ${pkgs.jless}/bin/jless
      else
        nix eval "${flakePath}#$CLASS.$HOSTNAME.config.$OPTIONS"
      fi
    '';
  in [nix-option];
}
