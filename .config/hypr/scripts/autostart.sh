#!/bin/bash

swww-daemon &
# Try to restore the last used wallpaper
sleep 0.5 && swww restore || swww img ~/Pictures/hyprland/png.png --transition-step 80 --transition-fps 80 --transition-type center --transition-duration 1
