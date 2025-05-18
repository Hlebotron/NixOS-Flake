{ pkgs ? import <nixpkgs> {}, ...}:
pkgs.stdenv.mkDerivation rec {
    name = "bepinex";
    system = "x86_64-linux";
    version = "5.4.23.3";
    src = builtins.fetchurl {
      url = "https://github.com/BepInEx/BepInEx/releases/download/v${version}/BepInEx_linux_x86_${version}.zip";
      sha256 = "sha256:1ym3gl7m2k3y1rpq94kdjkapzl4db22h6r8s1f08yibw1gnrpdr4"; 
    };
    buildInputs = with pkgs; [
      unzip
      #autoPatchElfHook
    ];
    unpackPhase = ''
      ${pkgs.unzip}/bin/unzip -d $out $src
    '';
}
