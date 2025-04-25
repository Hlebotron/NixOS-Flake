{
  description = "Home Manager configuration of sasha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { nixpkgs, home-manager, nixvim, stylix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.bepinex = pkgs.mkDerivation {
        name = "bepinex";
        inherit system;
        version = "5.4.23.3";
        src = pkgs.fetchUrl {
          url = "https://github.com/BepInEx/BepInEx/releases/download/v${version}/BepInEx_linux_x86_${version}.zip";
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
      homeConfigurations."sasha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home.nix 
          nixvim.homeManagerModules.nixvim
          stylix.homeManagerModules.stylix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
