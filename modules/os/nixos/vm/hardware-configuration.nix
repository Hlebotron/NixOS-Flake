{ self, inputs, ...}:

{
  flake.modules.nixos.vm-hw = { config, lib, pkgs, modulesPath, ... }: {
    boot = {
      initrd = {
        availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
        kernelModules = [];
      };
      
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = [];
    };
    
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixroot";
      fsType = "ext4";
    };
    
    swapDevices = [
      {
        device = "/dev/disk/by-label/swap";
      }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
