{ pkgs, inputs, ... }:

{
	home.packages = [
		inputs.zig.packages."${pkgs.system}".master
		inputs.zls.packages."${pkgs.system}".zls
	];
}
