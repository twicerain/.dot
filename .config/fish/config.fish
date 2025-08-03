# vi mode
fish_vi_key_bindings
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_replace underscore
set -g fish_cursor_external line
set -g fish_cursor_visual block

bind --mode insert ctrl-y accept-autosuggestion

# exports
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx MANPAGER "nvim +Man!"

set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set --universal nvm_default_version v24.5.0

# abbreviations
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr ..... "cd ../../../.."
abbr - "cd -"

abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -pv"
abbr l ll

abbr vim nvim
abbr vi nvim
abbr v nvim
abbr nv nvim
abbr :q exit

abbr lg lazygit
abbr ld lazydocker

# abbr grep rg
abbr find fd
abbr se "sudo systemctl enable --now"
abbr sd "sudo systemctl disable --now"
abbr sr "sudo systemctl restart"
abbr so "sudo systemctl stop"
abbr sa "sudo systemctl start"
abbr sf "systemctl --failed --all"
abbr s systemctl
abbr su "systemctl --user"
abbr ssh "TERM=xterm-256color ssh"

abbr dup "docker compose up --build --remove-orphans -d"

# deno
abbr dr "deno run"
abbr dra "deno run --allow-all"

# aliases
alias ls "eza --color=always --icons --group-directories-first"
alias la "eza --color=always --icons --group-directories-first --all"
alias ll "eza --color=always --icons --group-directories-first --all --long"

alias fzfp "fzf --style full --preview 'bat --color=always --style=numbers --line-range=256 {}' --bind 'focus:transform-header:file --brief {}'"
alias inv "fzf --style full --preview 'bat --color=always --style=numbers --line-range=256 {}' --bind 'focus:transform-header:file --brief {}' --bind 'enter:become(nvim {})'"

alias lazydot "lazygit --git-dir=$HOME/.dot --work-tree=$HOME"

alias wallpaper "~/.config/hyprland-de/scripts/wallpaper.sh"

# start hyprland
if uwsm check may-start; and uwsm select
    exec uwsm start default
end

# start interactive shell
if status is-interactive
    starship init fish | source
    zoxide init fish | source
    fzf --fish | source
    eval (zellij setup --generate-auto-start fish | string collect)
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
