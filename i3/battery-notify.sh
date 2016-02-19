#!/usr/bin/bash

# low battery in %
LOW_BATTERY="10"
# critical battery in %
CRITICAL_BATTERY="5"
# path to battery /sys
BATTERY_PATH="/sys/class/power_supply/BAT0/"

if [ -f "$BATTERY_PATH/status" ] && [ $(cat $BATTERY_PATH/status) == "Discharging"]; then
  CURRENT_BATTERY=$(cat $BATTERY_PATH/capacity)
  if [ "$CURRENT_BATTERY" -lt "$CRITICAL_BATTERY" ]; then
    notify-send -u critical -t 5000 -i battery-caution "Battery is extremly low - $CURRENT_BATTERY %."
  elif [ "$CURRENT_BATTERY" -lt "$LOW_BATTERY" ]; then
    notify-send -u critical -t 5000 -i battery-low "Battery is low - $CURRENT_BATTERY %."
  fi
fi

