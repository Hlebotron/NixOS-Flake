{ self, inputs, ... }:

{
  flake.modules.nixos.devops = { config, lib, pkgs, inputs, ... }: {
    services = {
      minecraft-server = {
        enable = false;
        eula = true;
      };
      k3s = {
        enable = true;
        role = "server";
      };
    };
  };
}
