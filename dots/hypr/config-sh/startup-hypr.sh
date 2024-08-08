#! /usr/bin/env bash

#{ dunst; hyprpaper; waybar; hypridle; nm-applet; } &

dunst &
#hyprpaper &
swww-daemon &
waybar &
nm-applet --indicator &
hypridle &

swww img ../wallpaper/2.webm
