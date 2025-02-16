{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.hardware) ldTernary;
  inherit (lib.secrets) mkSecret mkSecretWithPath;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  inherit (config.garden.system) mainUser;
  homeDir = config.home-manager.users.${mainUser}.home.homeDirectory;
  sshDir = homeDir + "/.ssh";

  userGroup = ldTernary pkgs "users" "admin";
in {
  imports = [inputs.agenix.nixosModules.default];

  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  age = {
    # check the main users ssh key and the system key to see if it is safe
    # to decrypt the secrets
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${sshDir}/id_ed25519"
    ];

    secretsDir = mkIf isDarwin "/private/tmp/agenix";
    secretsMountPoint = mkIf isDarwin "/private/tmp/agenix.d";

    secrets = {
      secret1 = mkSecret {
        file = "secret1";
        owner = mainUser;
        group = userGroup;
      };
    };
  };
}
