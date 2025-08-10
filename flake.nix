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
			# url = "github:zigtools/zls";
			url = "path:/home/droid/src/zls";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zig = {
			url = "github:mitchellh/zig-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nordvpn.url = "path:/home/droid/nix/nordvpn";

		clip.url = "path:/home/droid/proj/clip";
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations.nick = nixpkgs.lib.nixosSystem (
			let
				pkgs = import nixpkgs {
					system = "aarch64-linux";
					config = {
						allowUnfree = true;
						allowUnfreePredicate = _: true;
					};
				};
			in {
				system = "aarch64-linux";

				specialArgs = {inherit pkgs inputs;};

				modules = [
					./configuration.nix
					inputs.nordvpn.nixosModules.nordvpn
					({ ... }: {
						environment.systemPackages = [
							inputs.clip.packages."aarch64-linux".clip
							inputs.clip.packages."aarch64-linux".wl-clip-copy
							inputs.clip.packages."aarch64-linux".wl-clip-paste
						];
					})
				];
			}
		);
  };
}
