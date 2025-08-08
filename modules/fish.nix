{ lib, pkgs, ... }:

{
  home.packages = [
    pkgs.fish
    pkgs.fzf
  ];

  programs.fish = {
    enable = true;
    generateCompletions = true;

    functions = {
      fish_greeting = "";
      fish_prompt = lib.fileContents ../dotfiles/fish/functions/fish_prompt.fish;
      fish_user_key_bindings = lib.fileContents ../dotfiles/fish/functions/fish_user_key_bindings.fish;
    };

    shellAliases = {
      py = "python3";
    };

    shellInit = lib.fileContents ../dotfiles/fish/config.fish;
  };

  home.file.".config/fish/themes/Catppuccin Mocha.theme".source = ../dotfiles/fish/themes + "/Catppuccin Mocha.theme";
}
