{ pkgs, lib, config, inputs, ... }:

{
	home.packages = [
		inputs.zig.packages."${pkgs.system}".master
		inputs.zls.packages."${pkgs.system}".zls
	];

	programs.nixvim.plugins.zig = lib.mkIf config.programs.nixvim.enable {
		enable = true;
		settings = {
			fmt_autosave = 0;
			zig_lib_path = "/etc/profiles/per-user/droid/lib/std/";
			zig_exe_path = "/etc/profiles/per-user/droid/bin/zig";
		};
	};
}
