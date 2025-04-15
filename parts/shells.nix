{
  perSystem = {
    pkgs,
    self',
    inputs',
    ...
  }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        name = "snowflake";
        meta.description = "Development shell for this configuration";

        packages = [
          pkgs.gitMinimal # flakes require git
          pkgs.cocogitto # git helpers
          self'.formatter # nix formatter
          pkgs.nix-output-monitor # get clean diff between generations
          inputs'.agenix.packages.agenix # secrets
        ];
      };

      nixpkgs = pkgs.mkShellNoCC {
        packages = builtins.attrValues {
          inherit
            (pkgs)
            # package creation helpers
            nurl
            nix-init
            # nixpkgs dev stuff
            hydra-check
            nixpkgs-lint
            nixpkgs-review
            nixpkgs-hammering
            # nix helpers
            nix-melt
            nix-tree
            nix-inspect
            nix-search-cli
            ;
        };
      };
    };
  };
}
