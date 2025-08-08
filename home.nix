{ lib, config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    modules/fish.nix
    modules/nvim.nix
  ];

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
