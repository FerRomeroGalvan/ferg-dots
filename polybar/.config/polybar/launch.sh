#!/usr/bin/env bash
# =============================================================================
# polybar/launch.sh — detect hardware, kill old bar, launch fresh
# Also starts a watcher that relaunches polybar on display changes
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

# Kill any running polybar AND any running display watcher (avoid stacking)
killall -q polybar
pkill -f "polybar-display-watch" 2>/dev/null
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

polybar candle --config="$HOME/.config/polybar/config.ini" 2>&1 | \
    tee -a /tmp/polybar.log & disown

echo "▌ Polybar launched"

# -----------------------------------------------------------------------------
# Display watcher — relaunches polybar when monitor config changes.
# Uses xrandr's RRScreenChangeNotify events. Runs in background, marked with
# a recognizable process name so we can find and kill it later.
# -----------------------------------------------------------------------------
(
    exec -a polybar-display-watch bash -c '
        # Track screen geometry; relaunch polybar when it changes
        prev=$(xrandr | grep " connected" | awk "{print \$3}")
        while sleep 2; do
            curr=$(xrandr | grep " connected" | awk "{print \$3}")
            if [[ "$curr" != "$prev" ]]; then
                echo "▌ Display change detected — restarting polybar" >> /tmp/polybar.log
                killall -q polybar
                while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done
                polybar candle --config="$HOME/.config/polybar/config.ini" >> /tmp/polybar.log 2>&1 &
                prev="$curr"
            fi
        done
    '
) & disown

echo "▌ Display watcher started"
