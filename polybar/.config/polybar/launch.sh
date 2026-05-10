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

# Lowercase the day/month abbreviations for the date module — matches the
# splashpage's all-lowercase tone. Using POSIX 'C' gives us "Sat 09 May";
# we use a custom locale post-processing approach instead. The simplest
# cross-distro trick: set LANG/LC_TIME to a locale you've already lowercased.
# Most Linux systems just give you "Sat" — to force lowercase we use a
# wrapper. For now we set LC_TIME=C and rely on the config; if you still see
# capitalized days, we can switch to a custom date wrapper module.
export LC_TIME=C

# Kill any running polybar AND any running display watcher
killall -q polybar
pkill -f "polybar-display-watch" 2>/dev/null
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

polybar candle --config="$HOME/.config/polybar/config.ini" 2>&1 | \
    tee -a /tmp/polybar.log & disown

echo "▌ Polybar launched"

# -----------------------------------------------------------------------------
# Display watcher
# -----------------------------------------------------------------------------
(
    exec -a polybar-display-watch bash -c '
        prev=$(xrandr | grep " connected" | awk "{print \$3}")
        while sleep 2; do
            curr=$(xrandr | grep " connected" | awk "{print \$3}")
            if [[ "$curr" != "$prev" ]]; then
                echo "▌ Display change detected — restarting polybar" >> /tmp/polybar.log
                killall -q polybar
                while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done
                LC_TIME=C polybar candle --config="$HOME/.config/polybar/config.ini" >> /tmp/polybar.log 2>&1 &
                prev="$curr"
            fi
        done
    '
) & disown

echo "▌ Display watcher started"
