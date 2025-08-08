# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block blink
# Set the insert mode cursor to a line
set fish_cursor_insert line blink
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore

set fish_vi_force_cursor

set -e fish_features

fish_config theme choose "Catppuccin Mocha"

nix-your-shell fish | source
