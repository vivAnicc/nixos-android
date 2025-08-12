{ pkgs, ... }:

{
  imports = [
    modules/fish.nix
    modules/nvim.nix
		# modules/zig.nix
		modules/c.nix
  ];

  home = {
    username = "droid";
    homeDirectory = "/home/droid";
    stateVersion = "25.11";

		packages = [
			pkgs.file
		];
  };

  programs.home-manager.enable = true;
}
