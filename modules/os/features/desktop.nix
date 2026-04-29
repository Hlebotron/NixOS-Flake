{ self, inputs, ... }:

{
  flake.modules.nixos.desktop = { config, lib, pkgs, stylix, inputs, ... }: {
    programs = {
      #dconf.enable = true;
      hyprland.enable = true;
      hyprlock.enable = true;
      niri.enable = true;
      
      #ladybird.enable = false;
      firefox.enable = true;

      # nix-ld.enable = false;
      xwayland.enable = true;
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
    hardware.graphics.enable = true;

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk        
          xdg-desktop-portal
        ];
        wlr.enable = true;
      };
    };
  };
}
