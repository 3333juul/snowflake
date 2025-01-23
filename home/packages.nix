{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # python
    python3
    # nix code formatter
    alejandra
  ];
}
