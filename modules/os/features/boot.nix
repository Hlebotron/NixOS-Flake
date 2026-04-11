{ self, inputs, ...}:

{
  flake.modules.nixos = {
    
    boot-mbr = { config, lib, pkgs, modulesPath, ... }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
      boot = {
        initrd = {
          availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
          kernelModules = [];
        };
        
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = [];
      };
      
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/NIXROOT";
          fsType = "ext4";
        };
      };
      
      swapDevices = [
        {
          device = "/dev/disk/by-label/NIXSWAP";
        }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
    
    boot-gpt = { config, lib, pkgs, modulesPath, ... }: {
      imports = [
        self.modules.nixos.boot-mbr
      ];
      
      fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
    };
    
  };
}
