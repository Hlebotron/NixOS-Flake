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
    
    filesystems."/" = {
      device = "/dev/disk/by-uuid/0dfae9f9-dc0f-4466-befd-b21b6ce81140";
      fsType = "ext4";
    };
    
    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
