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
        manifests = {
          deployments.source = ./Kubernetes/deployment.yaml;
          services.source = ./Kubernetes/service.yaml;
          # routing.source = ./Kubernetes/routing.yaml;          
        };
        images = [
          (pkgs.dockerTools.pullImage {
            imageName = "ghcr.io/immich-app/immich-server"; # altran1502/immich-server
            imageDigest = "sha256:c15bff75068effb03f4355997d03dc7e0fc58720c2b54ad6f7f10d1bc57efaa5";
            hash = "sha256-nvscljSiCxbOP0Vv2kEKxTSGbxmjFIuQeOsjKAEESO3Q=";
            finalImageTag = "release";
          })
        ];
      };
    };
  };
}
