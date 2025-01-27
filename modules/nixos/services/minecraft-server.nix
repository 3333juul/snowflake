{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      server1 = {
        enable = true;
        autoStart = false;
        package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          gamemode = "survival";
          difficulty = "easy";
          online-mode = "false";
          allow-cheats = "true";
          /**/
        };
        whitelist = {
          /**/
        };

        symlinks = {
          mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
            FabricAPI = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/SKPWumQf/fabric-api-0.92.3%2B1.20.1.jar";
              hash = "sha256-avxiVnCUbB72x3YYv2htiTrqbTm6GQ1M3Ess2HhCG04=";
            };

            # Xaero = pkgs.fetchurl {
            #   url = "https://cdn.modrinth.com/data/1bokaNcj/versions/UsAehJcE/Xaeros_Minimap_24.7.1_Fabric_1.20.jar";
            #   hash = "sha256-3U0+B3aB4fW9nAuu8jNNfIjGT3A9BOfakFSXPwltYko=";
            # };

            # Swords = pkgs.fetchurl {
            #   url = "https://cdn.modrinth.com/data/bK3Ubu9p/versions/xe5E39uw/simplyswords-fabric-1.56.0-1.20.1.jar";
            #   hash = "sha256-3br4q4WmsAOoF9DA6Bfcvfn8/muInHKf9yxLajsfPpo=";
            # };
          });
        };
      };

      # ...
    };
  };

  # allow minecraft server port
  networking.firewall.allowedTCPPorts = [
    25565
  ];
}
