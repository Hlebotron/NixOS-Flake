{ config, pkgs, nixvim, ... }:

{
  imports = [
    #./scripts.nix
    ./nixvim.nix
  ];
  programs = {
    #nixvim = { nixvim, ... }: { import ./nixvim.nix; };
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
        nrs = "sudo nixos-rebuild switch --flake /etc/nixos";
        hms = "home-manager switch -f /etc/nixos/home/home.nix --flake /etc/nixos/home";
        home = "nvim /etc/nixos/home/home.nix";
        nixos = "cd /etc/nixos";
      };
      #interactiveShellInit = "fastfetch";
    };
    nh.enable = true;
    git = {
    	enable = true;
	userEmail = "stabasov@gmail.com"; 
	userName = "Hlebotron";
    };
  };
  home = {
    packages = with pkgs; [
      home-manager
      wl-clipboard
    ];
    username = "sasha";
    homeDirectory = "/home/sasha";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.

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
      # EDITOR = "emacs";
    };
  };
}
