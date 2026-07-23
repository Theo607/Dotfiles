#!/usr/bin/env bash

# Rofi Clipboard Selector with Cliphist
items=$(cliphist list 2>/dev/null)

if [ -z "$items" ]; then
    notify-send -u normal -t 3000 "Clipboard Empty" "Copy some text or images first!"
    exit 0
fi

selected=$(echo "$items" | rofi -dmenu -i -p "󰅌 Clipboard" -theme-str '
  window { width: 600px; border-radius: 12px; }
  listview { lines: 8; }
')

if [ -n "$selected" ]; then
    echo "$selected" | cliphist decode | wl-copy
fi
