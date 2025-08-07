{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-avf.url = "github:nix-community/nixos-avf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nick = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
      ];
    };
  };
}
