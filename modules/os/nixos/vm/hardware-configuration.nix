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
    
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
    };
    
    swapDevices = [
      {
        device = "/dev/disk/by-label/NIXSWAP";
      }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
