{ config, pkgs, nixvim, inputs, stylix, ... }:

let
    packages = with pkgs; [
      zeal
      luakit
      home-manager
      wl-clipboard
      zoxide
      kitty
      alacritty   
      prismlauncher
      steam
      fastfetch
      #cargo
      #rustup
      #rustc
      #patchelf
      #waybar
      git
      qutebrowser
      nextcloud-client
      #xorg.xrandr
      fuzzel
      zip
      unzip
      eog
      #gcc
      #autoPatchelfHook	
      gnome-terminal
      postman
      #python3
      papers
      libreoffice
      xorg.libXtst
      #jre_minimal
      #jdk
      #blender
      waybar
      sops
    ];
    packages-unstable = with pkgs.unstable; [
        
    ];
in {
  imports = [
    #./scripts.nix
    ./nixvim.nix
  ];
  #stylix.autoEnable = true;
  programs = {
    emacs = {
      enable = true;
      extraPackages = epkgs: with epkgs; [
        evil
      ];
    };
    bash = {
      enable = true;
      shellAliases = {
        nconf = "nvim /etc/nixos/configuration.nix";
        rl = "source ~/.bashrc";
        pkgs = "man configuration.nix";
        hlconf = "nvim ~/.config/hypr/hyprland.conf";
        server = "ssh sasha@192.168.1.169";
        addtime = "ssh sasha@192.168.1.103 \"~/addtime.sh $1\"";
        flake = "nvim /etc/nixos/flake.nix";
        n = "nvim";
        nrs = "nh os switch /etc/nixos";
        hms = "nh home switch /etc/nixos";
        home = "nvim /etc/nixos/home-manager/home.nix";
        nixos = "cd /etc/nixos";
        c = "z";
      };
      initExtra = "fastfetch";
      #shellInit = "fastfetch";
      #interactiveShellInit = "fastfetch";
    };
    nh.enable = true;
    git = {
    	enable = true;
	userEmail = "stabasov@gmail.com"; 
	userName = "Hlebotron";
    };
    nixvim.enable = true;
    zoxide.enable = true;
  };
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
    image = ./wallpaper.png;
    cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
    };
  };
  home = {
    packages = packages ++ packages-unstable;
    username = "sasha";
    homeDirectory = "/home/sasha";


    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/sasha/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      EDITOR = "nvim";
    };
    stateVersion = "24.05";  
  };
}
