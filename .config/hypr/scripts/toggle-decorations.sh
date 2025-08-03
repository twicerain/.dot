#!/usr/bin/env bash

# https://www.reddit.com/r/hyprland/comments/10b4pk1/comment/kom7e6i/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
on=$(hyprctl -j getoption animations:enabled | jq --raw-output '.int')

if [[ $on -eq 1 ]]; then
  hyprctl keyword animations:enabled 0
  hyprctl keyword decoration:blur:enabled 0
  hyprctl keyword decoration:inactive_opacity 1.0
  notify-send --app-name="sh" "rain" "Animations & blur disabled" \
    --icon=preferences-desktop \
    --expire-time=2000
else
  hyprctl keyword animations:enabled 1
  hyprctl keyword decoration:blur:enabled 1
  hyprctl keyword decoration:inactive_opacity 0.8
  notify-send --app-name="sh" "rain" "animations & blur enabled" \
    --icon=preferences-desktop \
    --expire-time=2000
fi
