#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
                 icon.padding_left=$RIGHT_BAR_ITEMS_SPACE \
           --subscribe volume volume_change \
