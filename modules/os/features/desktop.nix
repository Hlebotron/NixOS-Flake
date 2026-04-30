{ self, inputs, ... }:

{
  flake.modules.nixos.desktop = { config, lib, pkgs, stylix, inputs, ... }: {
    programs = {
      #dconf.enable = true;
      hyprland.enable = false;
      hyprlock.enable = true;
      niri.enable = true;
      
      #ladybird.enable = false;
      firefox.enable = true;

      # nix-ld.enable = false;
      xwayland.enable = true;
    };

    hardware.graphics.enable = true;

    services = {
      xserver = {
        desktopManager = {
          gnome.enable = true;
          xserver.i3.enable = true;
        };
        displayManager.gdm.enable = true;
      };
      pipewire = {
        enable = true;
        #pulse.enable = true;
        wireplumber.enable = true;
      };
    };

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
