#!/usr/bin/env bash

# https://www.reddit.com/r/hyprland/comments/10b4pk1/comment/kom7e6i/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
on=$(hyprctl -j getoption animations:enabled | jq --raw-output '.int')

if [[ $on -eq 1 ]]; then
  hyprctl keyword animations:enabled 0
  hyprctl keyword decoration:blur:enabled 0
  hyprctl keyword decoration:inactive_opacity 1.0
  hyprctl notify -1 2000 "rgb(e06c75)" "Decorations off"
else
  hyprctl keyword animations:enabled 1
  hyprctl keyword decoration:blur:enabled 1
  hyprctl keyword decoration:inactive_opacity 0.8
  hyprctl notify -1 2000 "rgb(98c379)" "Decorations on"
fi
