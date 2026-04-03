{ inputs, ... }:

{
  flake.modules.generic.stylix = { pkgs, stylix, ... }: {
    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
    };
  };
}
