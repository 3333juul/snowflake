{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Python
    (python3.withPackages (
      ps:
        with ps; [
          pytesseract
          pyqt5
          pynput
          numpy
        ]
    ))

    inputs.alejandra.defaultPackage.${system}
  ];
}
