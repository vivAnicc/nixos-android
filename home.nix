{ pkgs, ... }:

{
  imports = [
    modules/fish.nix
    modules/nvim.nix
		modules/zig.nix
  ];

  home = {
    username = "droid";
    homeDirectory = "/home/droid";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "less";
    };

		packages = [
			pkgs.file
		];
  };

  programs.home-manager.enable = true;
}
