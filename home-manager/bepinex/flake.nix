{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };
  outputs = { self, nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      }; 
    in { 
      packages.${system}.default = derivation rec {
        name = "bepinex";
        inherit system;
        version = "5.4.23.3";
        src = builtins.fetchzip {
          url = "https://github.com/BepInEx/BepInEx/releases/download/v${version}/BepInEx_linux_x86_${version}.zip";
          sha256 = "sha256:1ym3gl7m2k3y1rpq94kdjkapzl4db22h6r8s1f08yibw1gnrpdr4"; 
        };
      };
    };
}
