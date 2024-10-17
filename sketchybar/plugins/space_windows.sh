#!/usr/bin/env bash
 
source "$CONFIG_DIR/aerospace_utils.sh"

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  set_workspaces
fi
