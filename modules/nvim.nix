{ lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;

    plugins = {
      oil.enable = true;
      treesitter = {
	enable = true;
	settings.highlight.enable = true;
      };
      lspconfig.enable = true;
    };

    opts = {
      tabstop = 2;
      shiftwidth = 2;

      ignorecase = true;
      smartcase = true;
      incsearch = true;

      number = true;
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
  };
}
