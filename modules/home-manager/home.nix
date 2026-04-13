{ self, inputs, ... }:

{
  flake.homeConfigurations = {
    sasha = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = with inputs; [
          nixgl.overlay
        ];
      };
      modules = [
        inputs.stylix.homeModules.stylix
        self.modules.homeManager.sasha
        inputs.nix-index-db.homeModules.default
      ];
    };
  };
}
