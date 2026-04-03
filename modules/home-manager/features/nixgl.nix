{ self, inputs, ...}:

{
  flake.modules.homeManager.nixgl-intel = {
    
    targets.genericLinux = {
      enable = true;
      gpu.enable = true;
      nixGL = {
        installScripts = [ "mesa" "mesaPrime" ];
        vulkan.enable = true;
      };
    };
  };

  flake.modules.homeManager.nixgl-nvidia = {
    enable = true;
    targets.genericLinux = {
      gpu = {
        enable = true;
        version = "580.119.02";
        sha256 = "sha256-gCD139PuiK7no4mQ0MPSr+VHUemhcLqerdfqZwE47Nc=";
      };
      nixGL = {
        installScripts = [ "nvidia" "mesa" ];
        defaultWrapper = "nvidia";
        offloadWrapper = "nvidia";
        vulkan.enable = true;
      };
    };
  };
}
