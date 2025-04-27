# Features of config

- **OS** - [Fedora](https://fedoraproject.org/workstation/download)
- **WM** - Hypr
- **Shell** - Zsh
- **Term** - [Alacritty](https://github.com/alacritty/alacritty)
- **Compositor** - [Hyprland](https://hyprland.org/)
- **Prompt** - [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **App Launcher** - Rofi
- **Notification daemon** - mako
- **Bar** - Waybar
- **Color Scheme** - Catppuccin Frappe / Latte
- **System Theme** - Graphite-teal-nord
- **Icon Theme** - Reversal-orange

# About

> **Catppuccin Cartel ☕🐱**, a.k.a. the Frappe Mafia 

This rice is designed to be simple yet stylish, featuring a custom script that switches the color scheme between Catppuccin Frappe and Latte for programs that don't support it natively.

The rest of the system, controlled via `gsettings set org.gnome.desktop.interface color-scheme`, switches automatically between dark and light modes.

The script currently handles:

- Alacritty
- Tmux
- Btop
- Zathura

For Neovim and VS Code, the transition happens automatically on the fly — you just need to set Catppuccin Latte as the Light theme and Frappe as the Dark theme.

In Hyprland, the script also toggles the window border colors to match the Light and Dark variants.

In Waybar, it updates the colors of the text, icons, and workspace indicators accordingly.

https://github.com/user-attachments/assets/637d5052-c9b2-4d57-97a1-f314ef2ff0d6

# Usage

## Hyprland

Check hyprland.conf for the keybindings.

To execute the theme switch script:

```ini
bind = $mainMod, W, exec, theme_orchestrator  
```

To execute the sequential wallpaper change script:

```ini
bind = $mainMod, M, exec, zsh -i -c nextwall 
```

The sequential wallpaper script loads all wallpapers in the Pictures/hyprland directory, except for dark.png and light.png.

Move the scripts to ~/.local/bin.

## Zsh

To have Pokémon appear every time the terminal opens, install pokeget-rs, and add the following to a custom file.zsh in your $ZSH/custom folder:

If using Powerlevel10k, edit **.p10k.zsh** and set the Instant Prompt to quiet:

```bash
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
```

This will prevent the instant prompt message from showing when the Pokémon are displayed.
