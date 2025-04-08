{ nixvim, ... }: {
    programs.nixvim = {
      enable = true;
      opts = {
        
      };
      colorschemes.catppuccin.enable = true;
      plugins = {
        lazy.enable = true;
        #gitsigns = {
        #  enable = true;
        #  opts = {
        #    #signs = {
        #    #  add = 
        #    #};
        #  };
        #};
      };
    };
}
