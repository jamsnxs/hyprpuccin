## Enable
systemctl --user enable swww-daemon.service
systemctl --user enable swww-set-wallpaper.service
systemctl --user enable hyprpolkit-agent.service

## Reload
systemctl --user daemon-reload

## Disable
systemctl --user disable obsidian.service

## Stop
systemctl --user stop swww-set-wallpaper.service


## Status
systemctl --user list-timers  
systemctl --user status swww-daemon.service
systemctl --user status swww-set-wallpaper.service
systemctl --user status hyprpolkit-agent.service
systemd-cgls

## Logs
journalctl -b -u swww-daemon.service
journalctl -b -u swww-set-wallpaper.service


