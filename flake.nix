{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixgl";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
    stylix = {
        url = "github:danth/stylix/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    }
      (inputs.import-tree ./modules);
  # outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, nix-darwin, stylix, ... }@inputs:
  #   let
  #     system = "x86_64-linux";
  #     nixpkgs-overlay = final: prev: {
  #       unstable = nixpkgs-unstable.legacyPackages.${prev.system};
  #       # use this variant if unfree packages are needed:
  #       #unstable = import nixpkgs-unstable {
  #       #  inherit system;
  #       #  config.allowUnfree = true;
  #       #};
  #     };
  #     home-manager-overlay = final: prev: {};
  #   in {
  #     nixosConfigurations = {
  #       nixos-probook = nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         specialArgs = { inherit inputs; };
  #         modules = [
  #           # Overlays-module makes "pkgs.unstable" available in configuration.nix
  #           ({ config, pkgs, inputs, ... }: { nixpkgs.overlays = [ nixpkgs-overlay ]; })
  #           ./hosts/nixos-probook/configuration.nix
  #           #home-manager.nixosModules.home-manager {
  #           #  home-manager = {
  #           #    useGlobalPkgs = true; 
  #           #    useUserPackages = true;
  #           #    extraSpecialArgs = { inherit inputs; };
  #           #    users.sasha = import ./home-manager/home.nix;
  #           #    sharedModules = [
  #           #        nixvim.homeManagerModules.nixvim
  #           #        #stylix.homeManagerModules.stylix
  #           #    ];
  #           #  };
  #           #}
  #           stylix.nixosModules.stylix
  #         ];
  #       };
  #       maxim-dell = nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         specialArgs = { inherit inputs; };
  #         modules = [
  #           # Overlays-module makes "pkgs.unstable" available in configuration.nix
  #           ({ config, pkgs, inputs, ... }: { nixpkgs.overlays = [ nixpkgs-overlay ]; })
  #           ./hosts/maxim-dell/configuration.nix
  #           stylix.nixosModules.stylix
  #         ];
  #       };
  #       nixos-pc = nixpkgs.lib.nixosSystem {
  #         system = "x86_64-linux";
  #         specialArgs = { inherit inputs; };
  #         modules = [
  #           # Overlays-module makes "pkgs.unstable" available in configuration.nix
  #           ({ config, pkgs, inputs, ... }: { nixpkgs.overlays = [ nixpkgs-overlay ]; })
  #           ./hosts/nixos-pc/configuration.nix
  #           stylix.nixosModules.stylix
  #         ];
  #       };
  #     };
  #     darwinConfiguration.MacBook = nix-darwin.lib.darwinSystem {
  #       system = "aarch64-darwin";
  #       modules = [ 
  #           ./hosts/darwin/darwin-configuration.nix 
  #           #home-manager.darwinModules.home-manager {
  #           #    home-manager {
  #           #        users.sasha = import ./home-manager/home.nix;
  #           #    };
  #           #    users.users.sasha.home = "/Users/sasha";
  #           #}
  #       ];
  #       specialArgs = { inherit inputs; };
  #     };
  #   };
  }
