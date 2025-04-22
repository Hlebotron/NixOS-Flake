{ pkgs, nixvim, ... }: {
    programs.nixvim = {
      plugins = {
        lazy.enable = false;
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
            settings = {
                highlight.enable = true;
                indent.enable = true;
                incremental_selection.enable = true;
            };
        };
        harpoon = {
            enable = false;
            enableTelescope = true;
        };
        telescope.enable = false;
        lsp = {
            enable = true;
            servers = {
                rust_analyzer = {
                    enable = true;
                    installCargo = true;
                    installRustc = true;
                    installRustfmt = true;
                    autostart = true;
                    filetypes = [
                        "rs"
                    ];
                };
            };
        };
        sleuth.enable = true;
        gitsigns.enable = true;        
        lint = {
            enable = true;
            customLinters = {
                #rust_analyzer = {
                #    cmd = "";
                #};
            };
        };
        #lazydev = {
        #    enable = true;
        #    autoLoad = true;
        #};
      };

      opts = {
	number = true;
	relativenumber = true;
	mouse = "a";
	showmode = false;
	shiftwidth = 4;
	softtabstop = 4;
	expandtab = false;
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
