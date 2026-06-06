#!/bin/bash
# SwayNC Helper Scripts
# Uses standard notify-send for compatibility with SwayNC (and other daemons)

# Unique IDs for notification replacement (OSD/Updates)
# Note: Using -r <ID> replaces the notification with that ID instead of stacking.
VOLUME_ID=9910
BRIGHTNESS_ID=9911
BATTERY_ID=9912
NETWORK_ID=9913
MEDIA_ID=9914
CLIPBOARD_ID=9915

# Standard OSD hint for better handling by SwayNC (often makes the notification smaller/transient)
OSD_HINT="-h string:x-canonical-private-synchronous:osd"

# Volume notification with progress bar
volume_notify() {
    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)
    
    if [ -n "$muted" ]; then
        notify-send -a "volume" -u normal $OSD_HINT \
                 -r $VOLUME_ID \
                 -h int:value:0 "Volume Muted" "" -i audio-volume-muted
    else
        # Choose icon based on volume level
        if [ "$volume" -ge 67 ]; then ICON="audio-volume-high"
        elif [ "$volume" -ge 34 ]; then ICON="audio-volume-medium"
        elif [ "$volume" -ge 1 ]; then ICON="audio-volume-low"
        else ICON="audio-volume-zero"
        fi
        
        notify-send -a "volume" -u normal $OSD_HINT \
                 -r $VOLUME_ID \
                 -h int:value:$volume "Volume" "$volume%" -i $ICON
    fi
}

# Brightness notification with progress bar
brightness_notify() {
    brightness=$(brightnessctl get)
    max=$(brightnessctl max)
    percent=$((brightness * 100 / max))
    
    # Choose icon based on brightness level
    if [ "$percent" -ge 67 ]; then ICON="display-brightness-high"
    elif [ "$percent" -ge 34 ]; then ICON="display-brightness-medium"
    else ICON="display-brightness-low"
    fi
    
    notify-send -a "brightness" -u normal $OSD_HINT \
             -r $BRIGHTNESS_ID \
             -h int:value:$percent "Brightness" "$percent%" -i $ICON
}

# Battery notification (using a single replace ID for updates)
battery_notify() {
    capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null)
    status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null)
    
    if [ -n "$capacity" ]; then
        icon="battery-good"
        urgency="-u normal"
        
        if [ "$status" = "Charging" ]; then
            icon="battery-charging"
        elif [ "$capacity" -le 15 ]; then
            icon="battery-caution"
            urgency="-u critical"
        elif [ "$capacity" -le 30 ]; then
            icon="battery-low"
        fi
        
        notify-send -a "battery" $urgency -r $BATTERY_ID \
                 -h int:value:$capacity "Battery" "$capacity% ($status)" -i $icon
    fi
}

# Network notification
network_notify() {
    connected=$(nmcli -t -f NAME connection show --active | head -n1)
    
    if [ -n "$connected" ]; then
        notify-send -a "network" -r $NETWORK_ID \
                 "Network Connected" "$connected" -i network-wireless
    else
        notify-send -a "network" -u critical -r $NETWORK_ID \
                 "Network Disconnected" "" -i network-wireless-offline
    fi
}

# Screenshot notification
screenshot_notify() {
    notify-send -a "screenshot" "Screenshot Saved" "~/Pictures/Screenshots/" -i camera-photo
}

# Clipboard notification
clipboard_notify() {
    content=$(wl-paste | head -c 50)
    notify-send -a "clipboard" -r $CLIPBOARD_ID \
             "Copied to Clipboard" "$content..." -i edit-copy
}

# Media notification
media_notify() {
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    
    if [ -n "$title" ]; then
        # Use MEDIA_ID to update track info if playing continuously
        notify-send -a "media" -r $MEDIA_ID \
                 "$title" "$artist" -i spotify
    fi
}

# Close all notifications
close_all() {
    swaync-client -C
}

# Notification history
show_history() {
    swaync-client -H
}

# Pause/Resume notifications (DND)
toggle_pause() {
    swaync-client -t
    
    # Simple message to confirm DND status change (SwayNC handles the actual toggle)
    # You could query the status, but a simple message is often sufficient.
    notify-send -a "swaync" "Do Not Disturb" "Toggled" -i notifications
}

# Usage
case "$1" in
    volume) volume_notify ;;
    brightness) brightness_notify ;;
    battery) battery_notify ;;
    network) network_notify ;;
    screenshot) screenshot_notify ;;
    clipboard) clipboard_notify ;;
    media) media_notify ;;
    close) close_all ;;
    history) show_history ;;
    pause) toggle_pause ;;
    *)
        echo "Usage: $0 {volume|brightness|battery|network|screenshot|clipboard|media|close|history|pause}"
        exit 1
        ;;
esac