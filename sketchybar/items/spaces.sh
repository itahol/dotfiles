#!/bin/sh

source "$CONFIG_DIR/aerospace_utils.sh"
source "$CONFIG_DIR/colors.sh"

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sketchybar --add event aerospace_workspace_change

# Collect arguments for sketchybar in an array
batch_args=()

for i in $(aerospace list-workspaces --all); do
  sid=$i
  space=(
    icon="$sid"
    icon.highlight_color=$RED
    icon.padding_left=10
    icon.padding_right=10
    padding_left=2
    padding_right=2
    label.padding_right=20
    label.color=$GREY
    label.highlight_color=$WHITE
    label.font="sketchybar-app-font:Regular:16.0"
    label.y_offset=-1
    background.color=$BACKGROUND_1
    background.border_color=$BACKGROUND_2
    click_script="aerospace workspace $sid"
  )

  # Add arguments for this item to the batch
  batch_args+=(--add item space.$sid left)
  batch_args+=(--set space.$sid "${space[@]}")

  # You can still call this function individually per item if necessary
  batch_args+=($(load_workspace_icons $sid))
done

# Now, make one call to sketchybar with all the arguments
sketchybar "${batch_args[@]}"

set_workspaces


space_creator=(
  icon=❯
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change

