{ pkgs, lib, ...}: {
  options = {
    example.enable = lib.mkOption {
      type = lib.types.bool; 
      default = true;
    };
  };
  config = {
    example = pkgs.writeShellScriptBin "template" ''
      echo "pog"
    '';
  };
}
