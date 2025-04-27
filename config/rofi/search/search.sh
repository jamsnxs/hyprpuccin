#!/usr/bin/env bash

# Define the directory where Rofi themes are stored
dir="$HOME/.config/rofi/search/"
theme='style'

# Prompt user for search input using Rofi dmenu mode
SEARCH_STRING=$(rofi -dmenu -p "Search" -theme "${dir}/${theme}.rasi")

# Check if search string is empty, if so, exit
if [[ -z "$SEARCH_STRING" ]]; then
    exit 1
fi

# Check if the input is a command to change directories
if [[ "$SEARCH_STRING" == cd* ]]; then
    # Extract the directory path
    DIR_PATH=$(echo "$SEARCH_STRING" | awk '{print $2}')

    # If no path is specified, default to the home directory
    if [[ -z "$DIR_PATH" ]]; then
        DIR_PATH="$HOME"
    fi

    # Open Kitty and navigate to the specified directory
    kitty --directory="$DIR_PATH" &
    exit
fi

# Extract the first word as ENGINE and the rest as QUERY
ENGINE=$(echo "$SEARCH_STRING" | awk '{print $1}')
QUERY=$(echo "$SEARCH_STRING" | awk '{$1=""; print $0}' | sed 's/^ *//g')

# Handle search engine cases
case "$ENGINE" in
    yt)
        # If the engine is 'yt' and no query, go to YouTube homepage
        if [[ -z "$QUERY" ]]; then
            xdg-open "https://www.youtube.com"
        else
            # Search YouTube for the query
            ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /+/g')
            xdg-open "https://www.youtube.com/results?search_query=$ENCODED_QUERY"
        fi
        exit
        ;;
    arch)
        # Search Arch Wiki
        ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /+/g')
        xdg-open "https://wiki.archlinux.org/index.php?search=$ENCODED_QUERY"
        exit
        ;;
    hypr)
        # Search Hyprland documentation or relevant page
        ENCODED_QUERY=$(echo "$QUERY" | sed 's/ /+/g')
        xdg-open "https://wiki.hyprland.org/Getting-Started/$ENCODED_QUERY"
        exit
        ;;
    man)
        # If the engine is 'man', open the manual page for the command in Kitty
        MAN_COMMAND=$(echo "$QUERY" | sed 's/^ *//g')  # Trim leading whitespace
        if [[ -z "$MAN_COMMAND" ]]; then
            echo "No command specified for man. Please provide a command."
            exit 1
        else
            kitty -e man "$MAN_COMMAND" &  # Open the man page in Kitty
            exit
        fi
        ;;
    *)
        # If no known engine, search Google for the whole input
        ENCODED_QUERY=$(echo "$SEARCH_STRING" | sed 's/ /+/g')
        xdg-open "https://www.google.com/search?q=$ENCODED_QUERY"
        ;;
esac
