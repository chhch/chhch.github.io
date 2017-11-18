---
title: Konfiguration System
tags: [liste, elementary_os]
---

## Skripte

W-LAN (Verbindungsprobleme beheben)

```bash
sudo echo "options iwlwifi 11n_disable=1" >> /etc/modprobe.d/iwlwifi.conf
```

Nach Anmeldung ist für einige Minuten nur der Desktop zu sehen ((Bug #1596377)[https://bugs.launchpad.net/elementaryos/+bug/1596377])

```bash
sudo mv /etc/xdg/autostart/at-spi-dbus-bus.desktop /etc/xdg/autostart/at-spi-dbus-bus.disabled
```

Synaptics Touchpad (Aktivieren und Deaktivieren)

```bash
#!/bin/bash

if [[ $(xinput list "SynPS/2 Synaptics TouchPad" | grep -Ec "disabled") -eq 1 ]]; then
    xinput enable "SynPS/2 Synaptics TouchPad"
    DISPLAY=:0 notify-send --urgency=low --expire-time=2000 --icon=input-touchpad-symbolic --category=device.added "Touchpad aktiviert"
else
    xinput disable "SynPS/2 Synaptics TouchPad"
    DISPLAY=:0 notify-send --urgency=low --expire-time=2000 --icon=touchpad-disabled-symbolic --category=device.removed "Touchpad deaktiviert"
fi

exit 0
```

[ThinkVision LT1421](https://github.com/srw2d/tvlt1421_ubuntu) (Aktivieren und Deaktivieren)

```bash
#!/bin/bash

E_NODEVICE=3

# only one parameter is expected. either "on" or "off" (no quotes on the
# command line). "on" will attempt to turn on the displaylink device, "off"
# will try to turn it off, anything else will print usage and quit.
if [ $# -lt 1 ]
then
   echo "Usage: $0 [on/off]"
   exit
fi

case "$1" in

# turn it on
on)
   echo "Attenpting to turn on the device!"
   ;;
# turn it off
off)
   echo "Attempting to turn off the device!"
   ;;
# otherwise
*)
   echo "Invalid option given. Expected only 'on' or 'off' (without quotes)"
   exit 1
   ;;
esac

# get the number associated with the usb monitor (the X in DVI-X from the
DVIN=`xrandr | grep DVI* | cut -f1 -d' '`

#if [ -n "$DVIN" ]
   if [ "$DVIN" ]
then
   #echo "Device found at DVI-$DVIN"
   echo "Device found at $DVIN"
else
   echo "No appropriate device found!"
   exit $E_NODEVICE
fi

# now try to turn on or off
if [ "$1" == "on" ]
then
   xrandr --newmode "1368x768_59.90"  85.72  1368 1440 1584 1800  768 769 772 795  -HSync +Vsync
   xrandr --addmode $DVIN 1368x768_59.90
   xrandr --output $DVIN --off
   xrandr --output $DVIN --mode "1368x768_59.90" --left-of LVDS1 #Set left of LVDS1 for X1's default monitor, if you use another monitor, change LVDS1 to match your monitor
else
   # shouldn't be able to get here unless "$1" is "off"
   xrandr --output $DVIN --off
fi
```

[Wacom Tablet](http://linuxwacom.sourceforge.net/wiki/index.php?title=Consumer_Tablet_ExpressKey_Mapping_Issue) (Funktionen der Tasten festlegen)

```bash
#!/bin/bash

xsetwacom set "Wacom Intuos PT S Pad pad" button 3 button "key ctrl z"
xsetwacom set "Wacom Intuos PT S Pad pad" button 1 button "key ctrl shift z"
xsetwacom set "Wacom Intuos PT S Pad pad" button 9 button "key plus"
xsetwacom set "Wacom Intuos PT S Pad pad" button 8 button "key minus"
```
