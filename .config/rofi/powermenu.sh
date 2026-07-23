#!/usr/bin/env bash

# Rofi Powermenu with TokyoNight theme
lock="󰌾  Lock"
suspend="󰤄  Suspend"
logout="󰍃  Logout"
reboot="󰜉  Reboot"
shutdown="󰐥  Shutdown"

options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "󰐥 Power Menu" -theme-str '
  window { width: 300px; border-radius: 12px; }
  listview { lines: 5; }
')

case "$chosen" in
    "$lock")
        swaylock -S --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --ring-color 807da8 --key-hl-color e6db74 --inside-color 16162288
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        niri msg action quit
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
