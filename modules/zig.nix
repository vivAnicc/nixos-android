{ pkgs, lib, config, inputs, ... }:

{
	home.packages = [
		inputs.zig.packages."${pkgs.system}".master
		inputs.zls.packages."${pkgs.system}".zls
	];

	programs.nixvim.globals.zig_recommended_style = lib.mkIf config.programs.nixvim.enable 0;
}
