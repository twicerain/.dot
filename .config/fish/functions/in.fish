function in
    paru -Slq | fzf -q "$1" -m --preview 'paru -Si {1}' | xargs -ro paru -S
end
