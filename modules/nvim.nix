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
		EDITOR = "nvim";
		MANPAGER = "nvim +Man!";
	};

	home.packages = [
		pkgs.nixd
		inputs.clip.packages."aarch64-linux".clip
		inputs.clip.packages."aarch64-linux".wl-clip-copy
		inputs.clip.packages."aarch64-linux".wl-clip-paste
		pkgs.ripgrep
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
				};
			};

			lspconfig.enable = true;

			fzf-lua = {
				enable = true;
				profile = "default";
				settings.files = {
					git_icons = false;
					file_icons = false;
					color_icons = true;
				};
				keymaps = {
					"<leader>sf" = "files";
					"<leader>sb" = "buffers";
					"<leader>sh" = "helptags";
					"<leader>sr" = "resume";
					"<leader>sg" = "global";
				};
			};
		};

		lsp = {
			servers = {
				nixd.enable = true;
				zls.enable = true;
			};

			inlayHints.enable = false;

			onAttach = ''
				if client:supports_method('textDocument/completion') then
					vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
				end
			'';

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
				{
					key = "<leader>ls";
					lspBufAction = "signature_help";
				}
			];
		};

		extraConfigLua = ''
			vim.cmd("set completeopt+=noselect")
			'';

		opts = {
			tabstop = 2;
			shiftwidth = 2;

			ignorecase = true;
			smartcase = true;
			incsearch = true;
			hlsearch = false;

			inccommand = "split";

			number = true;
			relativenumber = true;
			signcolumn = "yes";
			cursorcolumn = false;

			smartindent = true;

			swapfile = false;
			undofile = true;

			termguicolors = true;

			winborder = "rounded";

			scrolloff = 5;
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
			{
				mode = "x";
				key = "<leader>y";
				action = "\"+y";
			}
			{
				mode = "x";
				key = "<leader>p";
				action = "\"+p";
			}
			{
				mode = "x";
				key = "<leader>P";
				action = "\"+P";
			}
			{
				mode = "n";
				key = "<Esc>";
				action = "<cmd>nohlsearch<CR>";
			}
			{
				mode = "n";
				key = "<C-c>";
				action = "<cmd>let @/=\"\"<CR>";
			}
		];
	};
}
