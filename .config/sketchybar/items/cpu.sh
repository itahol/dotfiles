#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon= \
                      icon.padding_left=$RIGHT_BAR_ITEMS_SPACE \
                      script="$PLUGIN_DIR/cpu.sh"
