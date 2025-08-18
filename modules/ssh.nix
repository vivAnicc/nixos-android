{ pkgs, ... }:

{
  services.openssh.enable = true;

  programs.ssh = {
    startAgent = true;

    knownHosts = {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "[10.121.67.34]:2222".publicKey = "AAAAC3NzaC1lZDI1NTE5AAAAIEn0p+TyFK0iWUGa2gR4SkwUmhsM2vbTVoB6WkRhQacf";
    };
  };

  environment.systemPackages = [
    pkgs.sshfs
  ];
  # fileSystems."/mnt/android" = {
  #   device = "user@10.121.67.34:/storage/emulated/0";
  #   fsType = "sshfs";
  #   options = [
  #     "nodev"
  #     "noatime"
  #     "allow_other"
  #     "ssh_command='ssh -p 2222'"
  #   ];
  # };
}
