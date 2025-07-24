#!/usr/bin/env bash

state="$(hyprctl -j clients)"
active="$(hyprctl -j activewindow)"
current_addr="$(jq -r '.address' <<<"$active")"
current_title="$(jq -r '.title' <<<"$active")"

# 1) Show only titles
title="$(
  jq -r '.[]
    | select(.monitor != -1)
    | .title' <<<"$state" |
    sed "s|^$current_title\$|-> &|" |
    sort -r |
    tofi --fuzzy-match=true
)"

[[ -z "$title" ]] && exit 0

# 2) Find the address & workspace for that title
addr="$(jq -r --arg t "$title" \
  '.[] | select(.monitor != -1 and .title == $t) | .address' \
  <<<"$state" | head -n1)"

ws="$(jq -r --arg t "$title" \
  '.[] | select(.monitor != -1 and .title == $t) | .workspace.name' \
  <<<"$state" | head -n1)"

if [[ "$addr" == "$current_addr" ]]; then
  echo "already focused, exiting"
  exit 0
fi

fs="$(jq -r --arg ws "$ws" \
  '.[] | select(.fullscreen>0 and .workspace.name==$ws) | .address' \
  <<<"$state")"

if [[ -z "$fs" ]]; then
  hyprctl dispatch focuswindow address:"$addr"
else
  notify-send "Complex switch" "$title"
  hyprctl --batch "
    dispatch focuswindow address:${fs}
    dispatch fullscreen 1
    dispatch focuswindow address:${addr}
    dispatch fullscreen 1
  "
fi

echo "→  $title  [$addr]"
