# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, stylix, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  programs = {
    #dconf.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    #ladybird.enable = false;
    firefox.enable = true;
    steam.enable = true;
    nix-ld.enable = true;
  };

  users = {
      users = {
      	sasha = {
              isNormalUser = true;
              extraGroups = [ "wheel" "nixos" "networkmanager" ]; # Enable ‘sudo’ for the user.
	};
	maxim = {
	  isNormalUser = true;
	  extraGroups = [ "networkmanager" ];
	};
      };
      extraGroups = { 
              "nixos".members = [ "sasha" ]; 
      };
  };

  #stylix = {
  #  enable = true;
  #  #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  #  base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
  #  image = ./wallpaper.png;
  #  polarity = "dark";
  #  cursor = {
  #      name = "Bibata-Modern-Classic";
  #      package = pkgs.bibata-cursors;
  #      size = 20;
  #  };
  #  #homeManagerIntegration.followSystem = true;
  #};
  hardware.bluetooth.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "maxim-dell"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager = {
	enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  systemd.services.limit = {
        serviceConfig = {};
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [
        	procps	
        	#util-linux
        ];
        script = ''
        	set -x
        	rootDir=/opt/limit
        	maxMinsFile="$rootDir/maxMins"
        	dateFile="$rootDir/date"
        	ticksLeftFile="$rootDir/ticksLeft"
        	tickLengthFile="$rootDir/tickLengthSecs"
        	userFile="$rootDir/user"
        	ticksUsedFile="$rootDir/ticksUsed"
        	maxMins=15
        	user=maxim
        	tickLength=10
        	#mkdir $rootDir
        	#opening=
        	#closing=

        	if [[ -z $(cat $maxMinsFile) ]]; then
        		echo $maxMins | tee $maxMinsFile
        	else
        		maxMins=$(cat $maxMinsFile)
        	fi
        	if [[ -z $(cat $userFile) ]]; then
        		echo $user | tee $userFile
        	else
        		user=$(cat $userFile)
        	fi
        	#if [[ -z $(cat $tickLengthFile) ]]; then
        	#	echo $tickLength | tee $tickLengthFile
        	#else
        	#	tickLength=$(cat $tickLengthfile)
        	#fi
        	if [[ -z $(cat $ticksLeftFile) ]]; then
        		ticksLeft=$(($($maxMins) * 60 / $tickLength))
        		echo $ticksLeft | tee $ticksLeftFile
        	fi
        	if [[ -z $(cat $ticksUsedFile) ]]; then
        		echo 0 | tee $ticksUsedFile
        	fi

        	currentDay1=$(cat $dateFile)
        	maxTicks=$(($maxMins * 60 / $tickLength))

        	while true; do
        		sleep $tickLength
        		ticksLeft=$(cat $ticksLeftFile)
        		currentDay1=$(cat $dateFile)
        		currentDay2=$(date -I)

        		if [ $currentDay1 != $currentDay2 ]; then
        			echo $currentDay2 | tee $dateFile
        			ticksLeft=$(($(cat $maxMinsFile) * 60 / $tickLength))
        			echo $ticksLeft | tee $ticksLeftFile
        			echo 0 | tee $ticksUsedFile
        		fi

        		if [[ $(users) == *"$user"* ]]; then
        			id=$(pgrep -o -u $user)
        			ticksLeft=$(($ticksLeft - 1))

        			ticksUsed=$(cat $ticksUsedFile)
        			ticksUsed=$(($ticksUsed + 1))
        			echo $ticksUsed | tee $ticksUsedFile

        			echo $ticksLeft | tee $ticksLeftFile

        			if [ $ticksLeft -le 0 ]; then
        				kill -9 $id
        			fi
        		fi
        	done			
        '';
  };
  services = {
	pipewire = {
		enable = true;
		pulse.enable = true;
	};
        printing = {
          enable = true;
          drivers = with pkgs; [ hplip ];
        };
        avahi.enable = true;
        mysql = {
          enable = true;
          package = pkgs.mariadb;
        };
        mpd = {
          enable = true;
          musicDirectory = "/home/sasha/Music";
          extraConfig = ''
            audio_output {
              type "pulse"
              name "My PulseAudio" # this can be whatever you want
            }
          '';
        };
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
  #documentation.man.generateCaches = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    home-manager
    #adwaita-icon-theme
  ];
  fonts.packages = with pkgs; [
    font-awesome
    iosevka
  ];

  nixpkgs.config.allowUnfree = true;
  #home-manager.users.maxim.nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

