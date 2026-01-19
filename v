#!/bin/bash
# Simple volume control for PCM mixer
# Keeps Master and Speaker at 100%
# Usage: v [+/-value] or v [value]

CARD=2
VOLUME_FILE="$HOME/.volume"

# Get current PCM level from mixer or file
get_volume() {
    # Try to get from mixer first
    local mixer_vol=$(amixer -c $CARD get PCM 2>/dev/null | grep -oP '\d+%' | head -1 | tr -d '%')
    
    if [ -n "$mixer_vol" ]; then
        echo "$mixer_vol" > "$VOLUME_FILE"
        echo "$mixer_vol"
    elif [ -f "$VOLUME_FILE" ]; then
        cat "$VOLUME_FILE"
    else
        echo "50"  # Default
    fi
}

# Set volume and save to file
set_volume() {
    local vol=$1
    
    # Clamp 0-100
    [ $vol -lt 0 ] && vol=0
    [ $vol -gt 100 ] && vol=100
    
    # Always set Master and Speaker to 100%
    amixer -q -c $CARD set Master 100%,100% 2>/dev/null
    amixer -q -c $CARD set Speaker 100%,100% 2>/dev/null
    amixer -q -c $CARD set PCM ${vol}%,${vol}% 2>/dev/null
    
    # Save to file
    echo "$vol" > "$VOLUME_FILE"
    
    echo "Volume: ${vol}%"
}

# No arguments - show current
if [ -z "$1" ]; then
    current=$(get_volume)
    echo "Current volume: ${current}%"
    exit 0
fi

current=$(get_volume)

case "$1" in
    +*)
        # v +5
        increment=${1#+}
        new_vol=$((current + increment))
        set_volume $new_vol
        ;;
    -*)
        # v -5
        decrement=${1#-}
        new_vol=$((current - decrement))
        set_volume $new_vol
        ;;
    [0-9]*)
        # v 50
        set_volume $1
        ;;
    *)
        echo "Usage:"
        echo "  v        - Show current volume"
        echo "  v 50     - Set volume to 50%"
        echo "  v +5     - Increase by 5%"
        echo "  v -5     - Decrease by 5%"
        exit 1
        ;;
esac
