{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

	home.packages = [
		pkgs.nixd
	];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

    plugins = {
      oil.enable = true;

      treesitter = {
				enable = true;
				settings = {
					highlight.enable = true;
					ensure_installed = "all";
					indent.enable = true;
				};
      };

      lspconfig.enable = true;

			web-devicons.enable = true;
			telescope = {
				enable = true;
				keymaps = {
					"<leader>f" = "find_files";
					"<leader>b" = "buffers";
					"<leader>h" = "help_tags";
				};
			};
    };

		lsp.servers = {
			nixd.enable = true;
			zls.enable = true;
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
