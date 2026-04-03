{ self, inputs, ... }:

{
  flake.modules.homeManager = {
    
    three-d = { pkgs, ... }: {
      home.packages = with pkgs; [
        orca-slicer
        blender
        kicad
        openscad
      ];
    };
    
    games = { pkgs, ... }: {
      home.packages = with pkgs; [
        wine64Packages.fonts
        winetricks
        protontricks
        wineWow64Packages.waylandFull
        steam
        
        # wine64
      ];
    };
    programming = { pkgs, ... }: {
      home.packages = with pkgs; [
        platformio
        clisp
        picocom
        claude-code
        gdb
        screen
        emacs-gtk
        neovim
        fastfetch
        zeal
        gnome-boxes
      ];
    };
    office = { pkgs, ... }: {
      home.packages = with pkgs; [
        libreoffice
        drawio
        libheif
        htmldoc
        pandoc
        eog
        nyxt
        qutebrowser
        texliveSmall
        geogebra
        evince
      ];
    };
    pinetime = { pkgs, ... }: {
      home.packages = with pkgs; [
        itd
        watchmate
      ];
    };
    editing = { pkgs, ... }: {
      home.packages = with pkgs; [
        kdePackages.kdenlive
        audacity
      ];
    };
    codecs = { pkgs, ... }: {
      home.packages = with pkgs; [
        libopus
        libvorbis
        openh264
      ];
    };

    nix = { pkgs, ... }: {
      home.packages = with pkgs; [
        nixgl.nixGLIntel
        nix-index
      ];
    };
    
    misc = { pkgs, ... }: {
      home.packages = with pkgs; [
        mpv
        mpc
        yt-dlp
        gtypist
      ];
    };
  };
}
