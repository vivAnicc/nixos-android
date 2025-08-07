set LOCATION unknown
if test "$TERM" = linux
    set LOCATION tty
else if test "$TERM" = xterm-256color
    set LOCATION phone
else if test "$TERM" = xterm-ghostty
    set LOCATION ghostty
else
    set LOCATION else
end

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block blink
# Set the insert mode cursor to a line
set fish_cursor_insert line blink
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

set fish_vi_force_cursor

if test $LOCATION = phone
    if not set -q fish_features
        set -Ux fish_features no-keyboard-protocols
        exec fish
    end
else
    set -e fish_features
end

# function from_bash
#     sed -e 's/\(.*\)=\(.*\); \(.*\)/set -x \1 \'\2\'; \3/' $argv
# end

# eval (ssh-agent -c) > /dev/null

# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME

# source "/home/nick/.jabba/jabba.fish"

# fish_add_path ~/.ghcup/bin/
# fish_add_path ~/.cabal/bin/
# fish_add_path ~/utils/
# fish_add_path ~/go/bin/
# fish_add_path ~/zig/compiler/
# fish_add_path ~/.local/share/flatpak/exports/share/
# fish_add_path ~/sudachi/

# source ~/.cargo/env.fish
# source ~/.config/fish/completions/*

# ZVM
# set -gx ZVM_INSTALL "$HOME/.zvm/self"
# set -gx PATH $PATH "$HOME/.zvm/bin"
# set -gx PATH $PATH "$ZVM_INSTALL/"
