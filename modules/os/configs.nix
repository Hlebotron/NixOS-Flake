{ self, inputs, lib, ... }:

{
  flake.nixosConfigurations = {
    
    probook = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.modules.nixos.probook-conf
        inputs.stylix.nixosModules.stylix
        inputs.disko.nixosModules.disko
        { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
      ];
    };
    
    pc = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.modules.nixos.pc-conf
        inputs.stylix.nixosModules.stylix
        inputs.disko.nixosModules.disko
        { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
      ];
    };
    
    dell = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.modules.nixos.dell-conf
        inputs.stylix.nixosModules.stylix
        inputs.disko.nixosModules.disko
        { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
      ];
    };

    vm = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.modules.nixos.vm-conf
        inputs.stylix.nixosModules.stylix
        inputs.disko.nixosModules.disko
        { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
      ];
    };
    
  };
}
