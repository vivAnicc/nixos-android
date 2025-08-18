{ config, lib, ... }:

{
  services.openssh.enable = true;

  programs.ssh = {
    startAgent = true;

    knownHosts = {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "[10.121.67.34]:2222".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
  };

  # programs.fish.shellInit = lib.mkIf config.programs.fish.enable "ssh-agent fish";
}
