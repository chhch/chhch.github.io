#!/bin/bash
## Synaptics Touchpad (Aktivieren und Deaktivieren)
if [[ $(xinput list "SynPS/2 Synaptics TouchPad" | grep -Ec "disabled") -eq 1 ]]; then
    xinput enable "SynPS/2 Synaptics TouchPad"
    DISPLAY=:0 notify-send --urgency=low --expire-time=2000 --icon=input-touchpad-symbolic --category=device.added "Touchpad aktiviert"
else
    xinput disable "SynPS/2 Synaptics TouchPad"
    DISPLAY=:0 notify-send --urgency=low --expire-time=2000 --icon=touchpad-disabled-symbolic --category=device.removed "Touchpad deaktiviert"
fi

exit 0
