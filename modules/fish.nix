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
      s = "sudo";
			rf = "rm -rf";

      n = "nix";
      nr = "nix repl";
      nd = "cd /etc/nixos";
      ngc = "sudo nix-collect-garbage -d";
      nbs = "nixos-rebuild switch --flake /etc/nixos#nick --sudo";
			nbr = "nixos-rebuild repl --flake /etc/nixos#nick";

      g = "git";
      ga = "git add .";
      gc = {
	setCursor = "%";
        expansion = "git commit -m '%'";
      };
      gca = "git commit --amend --no-edit";
    };
    functions = {
      d = ''
        mkdir $argv && cd $argv
      '';
      fish_greeting = "";
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
