{ lib, pkgs, inputs, ... }:

let
	parsers = lib.mapAttrsToList
		(_: a: a) 
		pkgs.vimPlugins.nvim-treesitter-parsers;
	parsers-pkgs = lib.filter
		lib.isDerivation
		parsers;
in {
  imports = [
    inputs.nixvim.homeModules.nixvim
	];

	home.sessionVariables = {
		# Set WAYLAND_DISPLAY to make nvim use clip as a clipboard provider
		WAYLAND_DISPLAY = "none";
	};

	home.packages = [
		pkgs.nixd
		inputs.clip.packages."aarch64-linux".clip
		inputs.clip.packages."aarch64-linux".wl-clip-copy
		inputs.clip.packages."aarch64-linux".wl-clip-paste
	] ++ parsers-pkgs;

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

    plugins = {
    	lz-n.enable = true;

      oil = {
				enable = true;
				lazyLoad.settings.cmd = "Oil";
				settings = {
					columns = [ "icons" ];
					constrain_cursor = "name";
					default_file_explorer = true;
					skip_confirm_for_simple_edits = true;
				};
			};

      treesitter = {
				enable = true;
				settings = {
					highlight.enable = true;
					indent.enable = true;
					# auto_install = true;
				};
      };

      lspconfig.enable = true;

			web-devicons = {
				enable = true;
			};

			telescope = {
				enable = true;
				lazyLoad.settings.cmd = "Telescope";
				keymaps = {
					"<leader>f" = "find_files";
					"<leader>b" = "buffers";
					"<leader>h" = "help_tags";
				};
			};
    };

		lsp = {
			servers = {
				nixd.enable = true;
				zls.enable = true;
			};

			inlayHints.enable = false;

			keymaps = [
				{
					key = "gd";
					lspBufAction = "definition";
				}
				{
					key = "gt";
					lspBufAction = "type_definition";
				}
				{
					key = "gr";
					lspBufAction = "references";
				}
				# {
				# 	key = "<leader>lh";
				# 	lspBufAction = "inlay_hint";
				# }
				{
					key = "<leader>ls";
					lspBufAction = "signature_help";
				}
			];
		};

    opts = {
      tabstop = 2;
      shiftwidth = 2;

      ignorecase = true;
      smartcase = true;
      incsearch = true;

      number = true;
			relativenumber = true;
      signcolumn = "yes";
      cursorcolumn = false;

      smartindent = true;

      swapfile = false;
      undofile = true;

      termguicolors = true;

      winborder = "rounded";
    };

    globals = {
      mapleader = " ";
    };

		keymaps = [
			{
				mode = "n";
				key = "<leader>e";
				action = "<cmd>Oil<CR>";
			}
		];

		extraPackages = [
			pkgs.nerd-fonts._0xproto
		];
  };
}
