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
      cool-server1 = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          gamemode = "creative";
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

            Paladin = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/SISz7Qd3/versions/E0I9zNUV/paladin-furniture-mod-1.3-fabric-mc1.20.1.jar";
              hash = "sha256-+y+GJt0cOr3p6jPL41voh1sWRI7TE+hY9NsPkLWisQQ=";
            };
          });
        };
      };

      # ...
    };
  };
}
