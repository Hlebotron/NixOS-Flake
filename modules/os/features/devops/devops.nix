{ self, inputs, ... }:

{
  flake.modules.nixos.devops = { config, lib, pkgs, inputs, ... }: {
    services.k3s = {
      enable = true;
      role = "server";
      manifests = {
        searxng.source = ./searxng.yaml;
        minecraft.source = ./minecraft.yaml;
	volumes.source = ./volumes.yaml;
	# immich.source = ./immich.yaml;
        # routing.source = ./routing.yaml;          
      };
      images = [
        # (pkgs.dockerTools.pullImage {
        #   imageName = "ghcr.io/immich-app/immich-server"; # altran1502/immich-server
        #   imageDigest = "sha256:c15bff75068effb03f4355997d03dc7e0fc58720c2b54ad6f7f10d1bc57efaa5";
        #   hash = "sha256-nvscljSiCxbOP0Vv2kEKxTSGbxmjFIuQeOsjKAEESO3";
        #   finalImageTag = "release";
        # })
      ];
    };
  };
}
