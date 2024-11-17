#!/bin/bash

sketchybar --add item calendar right \
           --set calendar icon=  \
                          icon.padding_left=$RIGHT_BAR_ITEMS_SPACE \
                          update_freq=30 \
                          script="$PLUGIN_DIR/calendar.sh"
