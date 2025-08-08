{ pkgs, lib, inputs, ... }:

{
	home.packages = [
		pkgs.zig
		pkgs.zls
	];
}
