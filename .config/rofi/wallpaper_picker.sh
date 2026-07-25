#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Dotfiles/Wallpapers"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Wallpaper Picker" "Directory $WALLPAPER_DIR does not exist." -u critical
    exit 1
fi

# List image files
files=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort)

if [ -z "$files" ]; then
    notify-send "Wallpaper Picker" "No wallpapers found in $WALLPAPER_DIR" -u warning
    exit 1
fi

# Display in Rofi
selected=$(echo "$files" | while read -r file; do echo -e "󰸉  $file"; done | rofi -dmenu -i -p "󰸉 Wallpapers" -theme "$HOME/Dotfiles/.config/rofi/style.rasi" -theme-str '
  window { width: 500px; border-radius: 14px; }
  listview { lines: 8; }
')

if [ -n "$selected" ]; then
    # Strip icon prefix
    filename=$(echo "$selected" | sed 's/^󰸉  //')
    wallpaper_path="$WALLPAPER_DIR/$filename"

    if [ -f "$wallpaper_path" ]; then
        "$HOME/.local/bin/walltheme" "$wallpaper_path"
        notify-send "Wallpaper Updated" "Applied: $filename" -i "$wallpaper_path"
    fi
fi
