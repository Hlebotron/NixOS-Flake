{ pkgs, nixvim, ... }: {
    programs.nixvim = {
      plugins = {
        lazy.enable = true;
        treesitter = {
            enable = true;
            #build = ":TSUpdate";
            #auto_install = true;
            grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
                bash
                c
                diff
                html
                lua
                luadoc
                markdown
                markdown_inline
                query
                vim
                vimdoc
                rust
                typst
                python
                nix
            ];
        };
        harpoon = {
            enable = false;
            enableTelescope = true;
        };
        telescope = {
            enable = false;
        };

        #gitsigns = {
        #  enable = true;
        #  opts = {
        #    #signs = {
        #    #  add = 
        #    #};
        #  };
        #};
      };
      opts = {
	number = true;
	relativenumber = true;
	mouse = "a";
	showmode = false;
	shiftwidth = 4;
	softtabstop = 4;
	expandtab = true;
	breakindent = true;
	undofile = true;
	ignorecase = true;
	smartcase = true;
	signcolumn = "yes";
	updatetime = 250;
	timeoutlen = 300;
	splitright = true;
	splitbelow = true;
	list = true;
	listchars = { 
		tab = "» ";
		trail = "·"; 
		nbsp = "␣";
	};
	inccommand = "split";
	cursorline = true;
	scrolloff = 10;
	confirm = true;
      };
      globals = {
    	mapleader = " ";
    	maplocalleader = " ";
    	have_nerd_font = false;
      };
      keymaps = [
            {
                mode = "n";
                key = "<Esc>";
                action = "<cmd>nohlsearch<CR>";
            }
            #"<leader>q" = 
            {
                mode = "n";
                key = "<Esc><Esc>"; 
                action = "<C-\\><C-n>";
            }
      ];
      colorschemes = {
        gruvbox.enable = false;
        catppuccin.enable = true;
      };
      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };
    };
}
