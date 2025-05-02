#!/bin/bash
# Run with nextwall in shell
# Caminho das imagens (ajuste se necessário)
wallpaper_dir="$HOME/Pictures/hyprland"
state_file="$HOME/.config/hypr/.last_wallpaper_index"

# Gera uma lista ordenada de arquivos, excluindo dark.png e light.png
mapfile -t wallpapers < <(find "$wallpaper_dir" -type f -not -name "dark.png" -not -name "light.png" | sort)

# Quantidade total de wallpapers
total=${#wallpapers[@]}

# Lê o índice anterior ou começa do -1 (pra iniciar em 0 depois)
if [[ -f "$state_file" ]]; then
    last_index=$(<"$state_file")
else
    last_index=-1
fi

# Calcula o próximo índice
next_index=$(( (last_index + 1) % total ))

# Define o próximo wallpaper
next_wallpaper="${wallpapers[$next_index]}"

# Aplica o wallpaper com transição
swww img "$next_wallpaper" --transition-step 80 --transition-fps 80 --transition-type any --transition-duration 1

# Salva o novo índice
echo "$next_index" > "$state_file"
