#!/usr/bin/env bash
 
source "$CONFIG_DIR/colors.sh"

load_workspace_icons() {
  local sid=$1
  apps=$(aerospace list-windows --workspace "$sid" --format "%{app-name}")

  icon_strip=""
  if [ -n "$apps" ]; then
    while IFS= read -r app; do
      # Append the icon mapped from the app
      icon_strip+=" $($CONFIG_DIR/icon_map.sh "$app")"
    done <<< "$apps"
    icon_strip=$(echo "$icon_strip" | xargs)  # Trim leading/trailing spaces
  else
    icon_strip="—"  # Fallback symbol if no apps
  fi

  echo "--animate sin 10 --set space.$sid label=$icon_strip"
}

set_workspaces() {
  # AEROSPACE_FOCUSED_WORKSPACE=$(aerospace list-workspaces --monitor focused --visible)
  batch_args=()
  batch_args+=($(load_workspace_icons "$AEROSPACE_PREV_WORKSPACE"))
  batch_args+=($(load_workspace_icons "$AEROSPACE_FOCUSED_WORKSPACE"))

  batch_args+=(--set space.$AEROSPACE_PREV_WORKSPACE icon.highlight=false)
  batch_args+=(--set space.$AEROSPACE_PREV_WORKSPACE label.highlight=false)
  batch_args+=(--set space.$AEROSPACE_PREV_WORKSPACE background.border_color=$BACKGROUND_2)
  batch_args+=(--set space.$AEROSPACE_FOCUSED_WORKSPACE icon.highlight=true)
  batch_args+=(--set space.$AEROSPACE_FOCUSED_WORKSPACE label.highlight=true)
  batch_args+=(--set space.$AEROSPACE_FOCUSED_WORKSPACE background.border_color=$GREY)

  AEROSPACE_EMPTY_WORKESPACE=$(aerospace list-workspaces --monitor focused --empty)
  for i in $AEROSPACE_EMPTY_WORKESPACE; do
    batch_args+=(--set space.$i display=0)
  done
  sketchybar "${batch_args[@]}"

  # sketchybar --set space.$AEROSPACE_FOCUSED_WORKSPACE display=$AEROSPACE_FOCUSED_MONITOR
}
