{ inputs, ... }:

{
  flake.modules.generic.stylix = { pkgs, stylix, ... }: {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
      image = ./wallpaper/WinXP.jpg;
      polarity = "dark";
      cursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
      };
    };
  };
}
