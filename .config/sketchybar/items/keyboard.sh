#!/bin/bash

keyboard=(
    icon.drawing=off
    label.font="$FONT:Semibold:14.0"
    icon.padding_left=$RIGHT_BAR_ITEMS_SPACE
    background.drawing=on
    background.border_color=$BACKGROUND_2
    label.padding_right=8
    label.padding_left=8
    script="$PLUGIN_DIR/keyboard.sh"
)

sketchybar --add item keyboard right        \
           --set keyboard "${keyboard[@]}"  \
           --add event keyboard_change "AppleSelectedInputSourcesChangedNotification" \
           --subscribe keyboard keyboard_change
