{ inputs, ... }:

{
  flake.modules.nixos = {
    users-public = { config, pkgs, stylix, ... }: {
      users = {
		    mutableUsers = true;
		    groups.nixos.members = [ "sasha" "deema" ];
		    users = { 
			    sasha = {
				    isNormalUser = true;
				    description = "Sasha";
				    extraGroups = [ "networkmanager" "wheel" ];
				    # packages = with pkgs; [
					  #   nvtopPackages.nvidia
					  #   pciutils
				    # ];
			    };
			    maxim = {
				    isNormalUser = true;
				    description = "Maxim";
				    extraGroups = [ "networkmanager" ];
				    initialPassword = "maxim";
			    };
			    deema = {
				    isNormalUser = true;
				    description = "Deema";
				    extraGroups = [ "networkmanager" "wheel" ];
			    };
		    };
	    };
    };
    users-private = { config, pkgs, stylix, ... }: {
      users = {
		    mutableUsers = true;
		    groups.nixos.members = [ "sasha" ];
		    users = { 
			    sasha = {
				    isNormalUser = true;
				    description = "Sasha";
				    extraGroups = [ "networkmanager" "wheel" ];
				    # packages = with pkgs; [
					  #   nvtopPackages.nvidia
					  #   pciutils
				    # ];
			    };
        };
      };
    };
  };
}
