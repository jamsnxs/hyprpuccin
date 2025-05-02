#!/bin/bash
# Path to wallpapers (adjust if necessary)
wallpaper_dir="$HOME/Pictures/hyprland/Gold"
state_file="$HOME/.config/hypr/.last_gold_wallpaper_index"  # Novo arquivo de estado para o diretório Gold

# Generate an ordered list of all files (without excluding dark.png and light.png)
mapfile -t wallpapers < <(find "$wallpaper_dir" -type f | sort)

# Total number of wallpapers
total=${#wallpapers[@]}

# Read the previous index or start from -1 (to start at 0 afterwards)
if [[ -f "$state_file" ]]; then
  last_index=$(<"$state_file")
else
  last_index=-1
fi

# Calculate the next index
next_index=$(((last_index + 1) % total))

# Set the next wallpaper
next_wallpaper="${wallpapers[$next_index]}"

# Apply the wallpaper with transition
swww img "$next_wallpaper" --transition-step 80 --transition-fps 80 --transition-type any --transition-duration 1

# Save the new index for the Gold directory
echo "$next_index" >"$state_file"

