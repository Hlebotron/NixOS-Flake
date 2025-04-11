{ pkgs, lib, ...}: {
    example = pkgs.writeShellScriptBin "template" ''
      echo "pog"
    '';
}
