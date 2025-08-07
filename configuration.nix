# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # include nixos-avf modules
    inputs.nixos-avf.nixosModules.avf
    inputs.home-manager.nixosModules.home-manager
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    backupFileExtension = "bck";
    extraSpecialArgs = {inherit inputs;};
    users."droid" = import ./home.nix;
    useUserPackages = true;
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    tldr
    vim
    neovim
    git
    wget

    inputs.helix.packages."${pkgs.system}".helix
  ];

  programs.fish.enable = true;
  users.users.droid.shell = pkgs.fish;

  # Change default user
  # avf.defaultUser = "droid";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
