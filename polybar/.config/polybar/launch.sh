#!/usr/bin/env bash
# =============================================================================
# polybar/launch.sh — detect hardware, kill old bar, launch fresh
# =============================================================================

# Detect battery and adapter
BATTERY=$(ls /sys/class/power_supply | grep -i bat | head -1)
ADAPTER=$(ls /sys/class/power_supply | grep -iE '^AC|^ADP' | head -1)

# Detect wifi interface (starts with wl)
NETWORK=$(ip link show | awk -F: '$2 ~ /^ wl/ {print $2}' | tr -d ' ' | head -1)

echo "▌ Battery:  ${BATTERY:-not found}"
echo "▌ Adapter:  ${ADAPTER:-not found}"
echo "▌ Network:  ${NETWORK:-not found}"

export BATTERY ADAPTER NETWORK

killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

polybar candle --config="$HOME/.config/polybar/config.ini" 2>&1 | \
    tee -a /tmp/polybar.log & disown

echo "▌ Polybar launched"
