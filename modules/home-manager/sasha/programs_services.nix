{ self, inputs, ...}:

{
  flake.modules.homeManager.programs-services = {
    programs = {
      # Let Home Manager install and manage itself.
      home-manager.enable = true;
      git = {
        enable = true;
        settings = {
          user = {
            email = "stabasov@gmail.com";
            name = "Hlebotron";
          };
        };
      };
      # steam.enable = true;
      man = {
        enable = true;
        generateCaches = true;
      };
    };

    services = {
      mpd = {
        enable = true;
        dataDir = /home/sasha/.mpd;
        musicDirectory = /home/sasha/Music;
        network.listenAddress = "/home/sasha/.mpd/socket";
      };
      mpd-mpris = {
        enable = true;
        mpd.host = "localhost";
      };
      mpris-proxy.enable = true;
      mako.enable = true;
    };
  };
}
