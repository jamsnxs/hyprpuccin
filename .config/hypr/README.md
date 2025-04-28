In your hyprland.conf, make sure to have at least the following in the Look and Feel section:
```bash
general {
    col.active_border = rgba(e1a5a6ee) rgba(dfff00ee) 50deg
    col.inactive_border = rgba(1a1b27ee) # Optional
}
```
If `col.active_border` is not present, the script will not be able to change the border colors to match the theme scheme!
