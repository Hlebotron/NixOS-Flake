{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      nixpkgs-overlay = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        #unstable = import nixpkgs-unstable {
        #  inherit system;
        #  config.allowUnfree = true;
        #};
      };
      home-manager-overlay = final: prev: {};
    in {
      nixosConfigurations.nixos-thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          # Overlays-module makes "pkgs.unstable" available in configuration.nix
          ({ config, pkgs, inputs, ... }: { nixpkgs.overlays = [ nixpkgs-overlay ]; })
          ./configuration.nix
          ./modules/modules.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true; 
              useUserPackages = true;
              users.sasha = ./home/home.nix;
            };
          }
          nixvim.homeManagerModules.nixvim {}
        ];
      };
      homeConfigurations.nixos-thinkpad = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          ({ ... }: { home-manager.overlays = [ home-manager-overlay ]; })
          ./home/home.nix
        ];
      };
    };
  }
