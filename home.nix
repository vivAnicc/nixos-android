{ lib, config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "droid";
    homeDirectory = "/home/droid";
    stateVersion = "25.05";

    sessionVariables = {
      EDITOR = "hx";
      MANPAGER = "less";
    };
  };

  programs.home-manager.enable = true;
}
