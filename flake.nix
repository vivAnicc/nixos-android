{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-avf.url = "github:nix-community/nixos-avf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # helix = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		zls = {
			url = "github:zigtools/zls";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				zig-overlay.follows = "zig";
			};
		};

		zig = {
			url = "github:mitchellh/zig-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# nordvpn.url = "path:/home/droid/nix/nordvpn";

		clip.url = "path:/home/droid/proj/clip";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem (
			let
				system = "aarch64-linux";
				unfree-pkgs = import nixpkgs {
					inherit system;
					config = {
						allowUnfree = true;
						allowUnfreePredicate = _: true;
					};
				};
			in {
				inherit system;

				specialArgs = {
					inherit inputs unfree-pkgs;
				};

				modules = [
					./configuration.nix
					# inputs.nordvpn.nixosModules.nordvpn
					({ ... }: {
						systemd.services = {
							forwarder_guest_launcher.wants = ["network-online.target"];
							shutdown_runner.wants = ["network-online.target"];
							storage_balloon_agent.wants = ["network-online.target"];
							ttyd.wants = ["network-online.target"];
						};
					})
				];
			}
		);
  };
}
