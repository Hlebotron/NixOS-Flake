{ pkgs ? import <nixpkgs> }: pkgs.stdenv.mkDerivation {
  name = "bepinex";
  system = "x86_64-linux";
  version = "";
  src = pkgs.fetchUrl {
    url = "https://github.com/BepInEx/BepInEx/releases/download/v5.4.23.3/BepInEx_linux_x86_5.4.23.3.zip";
    hash = ""; 
  };
  nativeBuildInputs = with pkgs; [
    unzip
    #autoPatchElfHook
  ];
  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip $src/BepInEx_linux_x86_5.4.23.3.zip 
  '';
}
