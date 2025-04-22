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
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    stylix = {
        url = "github:danth/stylix/release-24.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, nix-darwin, stylix, ... }@inputs:
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
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Overlays-module makes "pkgs.unstable" available in configuration.nix
          ({ config, pkgs, inputs, ... }: { nixpkgs.overlays = [ nixpkgs-overlay ]; })
          ./configuration.nix
          ./modules/modules.nix
          #home-manager.nixosModules.home-manager {
          #  home-manager = {
          #    useGlobalPkgs = true; 
          #    useUserPackages = true;
          #    extraSpecialArgs = { inherit inputs; };
          #    users.sasha = import ./home-manager/home.nix;
          #    sharedModules = [
          #        nixvim.homeManagerModules.nixvim
          #        #stylix.homeManagerModules.stylix
          #    ];
          #  };
          #}
          stylix.nixosModules.stylix
        ];
      };
      homeConfigurations.sasha = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
          overlays = [ nixpkgs-overlay ];
        };
        modules = [
          #({ ... }: { home-manager.overlays = [ home-manager-overlay ]; })
          ./home-manager/home.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeManagerModules.stylix
        ];
      };
      darwinConfiguration.MacBook = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ 
            ./darwin-configuration.nix 
            #home-manager.darwinModules.home-manager {
            #    home-manager {
            #        users.sasha = import ./home-manager/home.nix;
            #    };
            #    users.users.sasha.home = "/Users/sasha";
            #}
        ];
        specialArgs = { inherit inputs; };
      };
    };
  }
