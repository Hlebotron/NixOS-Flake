{ inputs, ... }:

{
  flake.modules.nixos.nvidia = { config, pkgs, stylix, lib, ... }: {
    nixpkgs.config = {
      allowUnfree = lib.mkDefault true;
      cudaSupport = true;
    };

    hardware = {
		  nvidia = {
			  package = config.boot.kernelPackages.nvidiaPackages.stable;
			  open = false;
		  };
		  nvidia-container-toolkit.enable = true;
		  graphics.enable = true;
	  };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
