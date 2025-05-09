#!/bin/bash
LOCKFILE="/tmp/theme-switch.lock"
if [ -e "$LOCKFILE" ]; then
  echo "Error: Script already running." >&2
  exit 1
fi
touch "$LOCKFILE"
trap 'rm -f "$LOCKFILE"' EXIT

CONFIG_DIR="$HOME/.config"
PICTURES_DIR="$HOME/Pictures/hyprland"
MAKO_DIR="$CONFIG_DIR/mako"

CONFIG_FILES=(
  "$CONFIG_DIR/alacritty/alacritty.toml"
  "$CONFIG_DIR/btop/btop.conf"
  "$CONFIG_DIR/hypr/hyprland.conf"
  "$CONFIG_DIR/waybar/style.css"
  "$CONFIG_DIR/zathura/zathurarc"
  "$CONFIG_DIR/tmux/tmux.conf"
)

declare -A DARK_THEME=(
  [alacritty]="catppuccin-frappe.toml"
  [btop]="$CONFIG_DIR/btop/themes/catppuccin_frappe.theme"
  [zathura]="catppuccin-frappe"
  [tmux]="frappe"
  [gtk]="Graphite-teal-Dark-nord"
  [icon]="Reversal-orange-dark"
  [color_scheme]="prefer-dark"
  [wallpaper]="$PICTURES_DIR/dark.png"
  [border]="col.active_border = rgba(7BA3F7EE) rgba(F7768EEE) 50deg"
  [waybar_colors]="s|#e1a5a6|#77b5a6|g;s|#db6d5a|#7899df|g"
  [mako_theme]="frappe_teal"
)

declare -A LIGHT_THEME=(
  [alacritty]="catppuccin-latte.toml"
  [btop]="$CONFIG_DIR/btop/themes/catppuccin_latte.theme"
  [zathura]="catppuccin-latte"
  [tmux]="latte"
  [gtk]="Graphite-teal-Light-nord"
  [icon]="Reversal-orange"
  [color_scheme]="prefer-light"
  [wallpaper]="$PICTURES_DIR/light.png"
  [border]="col.active_border = rgba(E1A5A6EE) rgba(DFFF00EE) 50deg"
  [waybar_colors]="s|#77b5a6|#e1a5a6|g;s|#7899df|#db6d5a|g"
  [mako_theme]="latte_teal"
)

check_config_files() {
  for file in "${CONFIG_FILES[@]}"; do
    [ -e "$file" ] || {
      echo "Error: Missing config file: $file" >&2
      exit 1
    }
  done
}

apply_mako_theme() {
  local selected="$1" other
  if [ "$selected" = "frappe_teal" ]; then
    other="latte_teal"
  else
    other="frappe_teal"
  fi

  # Rename currently active to original name
  [ -e "$MAKO_DIR/config" ] && mv "$MAKO_DIR/config" "$MAKO_DIR/$other"
  mv "$MAKO_DIR/$selected" "$MAKO_DIR/config"
  makoctl reload
}

apply_theme() {
  local theme_name="$1"
  local -n theme_ref="$2"

  [[ "$theme_name" != "dark" && "$theme_name" != "light" ]] && {
    echo "Error: Invalid theme. Use 'dark' or 'light'." >&2
    exit 1
  }

  sed -i "s|catppuccin-.*.toml|${theme_ref[alacritty]}|" "${CONFIG_FILES[0]}"
  sed -i "s|color_theme = .*|color_theme = \"${theme_ref[btop]}\"|" "${CONFIG_FILES[1]}"
  sed -i "s|include catppuccin-.*|include ${theme_ref[zathura]}|" "${CONFIG_FILES[4]}"
  sed -i "s|col.active_border = .*|${theme_ref[border]}|" "${CONFIG_FILES[2]}"
  sed -i "${theme_ref[waybar_colors]}" "${CONFIG_FILES[3]}"
  sed -i "s|set -g @catppuccin_flavor \".*\"|set -g @catppuccin_flavor \"${theme_ref[tmux]}\"|" "${CONFIG_FILES[5]}"

  gsettings set org.gnome.desktop.interface gtk-theme "${theme_ref[gtk]}" &
  gsettings set org.gnome.desktop.interface icon-theme "${theme_ref[icon]}" &
  gsettings set org.gnome.desktop.interface color-scheme "${theme_ref[color_scheme]}" &

  swww img "${theme_ref[wallpaper]}" --transition-step 80 --transition-fps 80 \
    --transition-type any --transition-duration 1 &

  tmux source "${CONFIG_FILES[5]}" &

  apply_mako_theme "${theme_ref[mako_theme]}"

  wait
}

check_config_files

if grep -q "catppuccin-latte.toml" "${CONFIG_FILES[0]}"; then
  apply_theme "dark" DARK_THEME
else
  apply_theme "light" LIGHT_THEME
fi
