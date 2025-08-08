{ lib, config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    modules/fish.nix
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
  };

  home = {
    username = "droid";
    homeDirectory = "/home/droid";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "less";
    };
  };

  programs.home-manager.enable = true;
}
