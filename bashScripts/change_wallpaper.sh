#!/home/flpwnix/.nix-profile/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/cows"

# Time interval (in seconds) between wallpaper changes (30 minutes = 1800 seconds)
INTERVAL=1800

# Function to change wallpaper
change_wallpaper() {
    # Select a random file from the wallpaper directory
    feh --bg-scale "$(find "$WALLPAPER_DIR" -type f | shuf -n 1)"
}

# Infinite loop to change wallpaper every $INTERVAL seconds
while true; do
    change_wallpaper
    sleep $INTERVAL
done
