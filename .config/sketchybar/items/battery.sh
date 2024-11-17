#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=120 \
                         icon.padding_left=$RIGHT_BAR_ITEMS_SPACE \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
