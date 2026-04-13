{ inputs, ... }:

{
  flake.modules.nixos.ollama = { config, pkgs, stylix, ... }: {
    ollama = {
			enable = true;
			acceleration = "cuda";
			host = "0.0.0.0";
			port = 11434;
			environmentVariables = {
				OLLAMA_ORIGINS = "*";
			};
		}; 
		caddy = {
			enable = true;
		};
  };
}

