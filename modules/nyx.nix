{ inputs, ... }:

{
	imports = [
		inputs.nyx.homeManagerModules.default
	];

	nyx = {
		enable     = true;
		username   = "droid";
		nixDirectory = "/etc/nixos";
		logDir     = "/home/droid/.nyx/logs";
		autoPush   = false;

		nyx-tool.enable    = true;
		nyx-rebuild.enable = true;
		nyx-cleanup.enable = true;
		nyx-tui.enable     = true;
	};
}
