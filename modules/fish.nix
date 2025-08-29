{ lib, pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.fish
    pkgs.fzf
    inputs.nix-your-shell.packages."${pkgs.system}".nix-your-shell
  ];

  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellAbbrs = {
      v = "nvim";
      la = "ls -A";
			rf = "rm -rf";
			"-" = "cd -";

      n = "nix";
      nr = "nix repl";
      nd = "cd /etc/nixos";
      ngc = "sudo nix-collect-garbage -d";
      nbs = "nixos-rebuild switch --sudo";
			nbr = "nixos-rebuild repl";

      g = "git";
      ga = "git add .";
      gc = {
	setCursor = "%";
        expansion = "git commit -m '%'";
      };
      gca = "git commit --amend --no-edit";

			tc = ''
        set -l directory (pwd)
        rm -rvf /home/droid/temp; mkdir -vp /home/droid/temp
        cd $directory
      '';
			td = "cd /home/droid/temp";

      sshm = "sshfs -p 2222 10.121.67.34:/storage/emulated/0 /mnt/android";
      sshu = "umount /mnt/android";
    };
    functions = {
      d = ''
        mkdir $argv && cd $argv
      '';
      close = ''
        sudo poweroff
      '';
      ensure = ''
        cd $HOME/nix/utils/save
        echo "++ [$argv]" >> packages.nix
        git add packages.nix
        git commit -m "Added package \"$argv\" to saved packages"
        nix build
        cd -
      '';

      fish_greeting = "";
      fish_command_not_found = "";
      fish_prompt = lib.fileContents ../dotfiles/fish/functions/fish_prompt.fish;
      fish_user_key_bindings = lib.fileContents ../dotfiles/fish/functions/fish_user_key_bindings.fish;
      fish_right_prompt = lib.fileContents ../dotfiles/fish/functions/fish_right_prompt.fish;
    };

    shellAliases = {
      py = "python3";
    };

    shellInit = lib.fileContents ../dotfiles/fish/config.fish;
  };

  home.file.".config/fish/themes/Catppuccin Mocha.theme".source = ../dotfiles/fish/themes + "/Catppuccin Mocha.theme";
}
