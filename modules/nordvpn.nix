{ ... }:

{
	services.nordvpn.enable = true;
	users.users.droid.extraGroups = ["nordvpn"];
	networking.firewall.allowedTCPPorts = [
		443
	];
	networking.firewall.allowedUDPPorts = [
		1194
	];
}
