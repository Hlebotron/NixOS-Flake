# Edit this configuration file to define what should be installed on

# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stylix, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	users = {
		mutableUsers = true;
		groups.nixos.members = [ "sasha" "deema" ];
		users = { 
			sasha = {
				isNormalUser = true;
				description = "Sasha";
				extraGroups = [ "networkmanager" "wheel" ];
				packages = with pkgs; [
					nvtopPackages.nvidia
					pciutils
				];
			};
			maxim = {
				isNormalUser = true;
				description = "Maxim";
				packages = with pkgs; [

				];
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

	# Install firefox.
	programs = {
		hyprland.enable = true;
		steam.enable = true;
		firefox.enable = true;
		nix-ld.enable = true;
	};

	stylix = {
		enable = true;
		#base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
		base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
		image = ./wallpaper.png;
		polarity = "dark";
		cursor = {
			name = "Bibata-Modern-Classic";
			package = pkgs.bibata-cursors;
			size = 20;
		};
		#homeManagerIntegration.followSystem = true;
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	#virtualisation = {
	#      docker.enable = true;
	#};
	environment = {
		systemPackages = with pkgs; [
			neovim
			wget
			docker
			git
			#jdk17_headless
			#jdk21_headless
			#pkg-config
			#libnotify
			#gparted
			#hyprpolkitagent
			nvidia-container-toolkit
			cudatoolkit
			home-manager
			#discord-ptb
		];
		#variables = {
		#	GDK_SCALE = "0.5";
		#};
	};

	fonts.packages = with pkgs; [
		iosevka
	];

	# Allow unfree packages
	nixpkgs.config = {
		allowUnfree = true;
		cudaSupport = true;
	};
	# Bootloader.
	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};  
	#boot.loader.grub = {
	#	enable = true;
	#      #devices = [];
	#};
  hardware = {
		nvidia = {
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			open = false;
		};
		nvidia-container-toolkit.enable = true;
		graphics.enable = true;
	};  

	networking = {
		hostName = "nixos-pc"; # Define your hostname.

		firewall.allowedTCPPorts = [ 12369 3000 11434 ];
		#firewall.maxUDPPorts = [ ... ];
		# Or disable the firewall altogether.
		#wireless.enable = true;  # Enables wireless support via wpa_supplicant.

		# Configure network proxy if necessary
		#proxy.default = "http://user:password@proxy:port/";
		#proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	};

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk        
      ];
      wlr.enable = true;
    };
  };

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Budapest";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	# Enable the X11 windowing system.
	services = {
		xserver = {
			enable = true;
			displayManager.gdm = {
				enable = true;
				wayland = true;
			};
			desktopManager.gnome.enable = true;
			xkb = {
				layout = "us";
				variant = "";
			};
			videoDrivers = [ "nvidia" ];
		};
		displayManager.sessionPackages = with pkgs; [ hyprland ];
		pulseaudio.enable = false;	
		printing.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			# If you want to use JACK applications, uncomment this
			#jack.enable = true;

			# use the example session manager (no others are packaged yet so this is enabled by default,
			# no need to redefine it in your config for now)
			#media-session.enable = true;
		};
		openssh.enable = true;
		ollama = {
			enable = false;
			acceleration = "cuda";
			host = "0.0.0.0";
			port = 11434;
			environmentVariables = {
				OLLAMA_ORIGINS = "*";
			};
		}; 
		caddy = {
			enable = true;
		};
	};
	systemd.services.limit = {
		serviceConfig = {
      ExecStart = "${pkgs.python3}/bin/python -u /etc/nixos/modules/limit.py";
    };
		wantedBy = [ "multi-user.target" ];
		path = with pkgs; [
			procps	
			#util-linux
		];
		# script = builtins.readFile ../../modules/limit.sh;
	};

	# Enable the GNOME Desktop Environment.
	# Configure keymap in X11
	# Enable CUPS to print documents.
	# Enable sound with pipewire.
	security = {
		rtkit.enable = true;
		polkit.extraConfig = '''';
	};
	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
	system.stateVersion = "24.11"; # Did you read the comment?
	#system.copySystemConfiguration = true;

}
