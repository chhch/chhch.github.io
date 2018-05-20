---
title: Systemkonfiguration
tags: [liste, elementary_os]
---

## Installierte Programme

-   [Git](https://git-scm.com/download/linux)
    -   `git config --global user.name "<name>"`
    -   `git config --global user.email "<mail>"`
-   [Oracle JDK](https://launchpad.net/~webupd8team/+archive/ubuntu/java)
-   [nodejs (npm)](https://github.com/nodesource/distributions)
-   [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
-   [KeePassXC](https://launchpad.net/~phoerious/+archive/ubuntu/keepassxc)
-   Datensicherung: Déjà Dup (AppCenter)
    -   Sichern: `~`, `/etc`
    -   Ignorieren: `Papierkorb`, `~/Downloads`, `~/gPodder/Downloads`, `~/.cache`
-   Dconf Editor (AppCenter)
    -   Tastenkürzel: `org/gnome/desktop/wm/keybindings`
-   Deutsche Rechtschreibprüfung: hunspell-de-de (Ubuntu)
-   [Chrome](https://www.google.com/intl/de/chrome/browser/desktop/index.html) (DEB legt Repository an)
    -   AdBlock
    -   dict-cc
    -   Hypothesis - Web & PDF Annotation
    -   Mendeley Importer
-   Firefox (AppCenter)
    -   AdBlock Plus
    -   Cookie AutoDelete
    -   NoScript
    -   Privacy Badger
    -   Toggle Referrer
-   [Atom](https://launchpad.net/~webupd8team/+archive/ubuntu/atom?field.series_filter=xenial)
    -   atom-beautify
    -   character-table
    -   file-icons
    -   intellij-idea-keymap
    -   language-latex
    -   latexer
    -   markdown-table-editor
    -   [spell- check](https://github.com/atom/spell-check/issues/161#issuecomment-336653098)
    -   typewriter-scroll
-   [Idea Ultimate](https://launchpad.net/~jonas-groeger/+archive/ubuntu/jetbrains)
    -   .ignore
    -   Kotlin
    -   Markdown support
    -   Mongo Plugin
    -   NodeJs
-   [Peek](https://code.launchpad.net/~peek-developers/+archive/ubuntu/stable)
-   [Mendeley](https://www.mendeley.com/guides/download-mendeley-desktop/ubuntu/instructions) (DEB legt Repository an)
-   [Vocal](https://github.com/needle-and-thread/vocal) (AppCenter) / [gPodder](https://launchpad.net/~thp/+archive/ubuntu/gpodder)
    -   <http://feeds.metaebene.me/cre/mp3>
    -   <http://forschergeist.de/feed/mp3>
    -   <http://www1.wdr.de/radio/podcasts/wdr5/dasphilosophischeradio100.podcast>
    -   <http://www.deutschlandfunk.de/podcast-der-politik-podcast.3292.de.podcast.xml>
    -   <http://www.deutschlandfunk.de/podcast-hintergrund.725.de.podcast.xml>
    -   <https://www.e-teaching.org/materialien/vodcast/podcast.xml>
    -   <http://www.br-online.de/podcast/kino-kino-shortcuts/cast.xml>
    -   <http://www.srf.ch/feed/podcast/hd/b7705a5d-4b68-4cb1-9404-03932cd8d569.xml>
    -   <http://www.tagesschau.de/export/video-podcast/webl/tagesschau/index.xml>
-   [Krita](https://launchpad.net/~kritalime/+archive/ubuntu/ppa)

## Entfernte Programme

-   Scratch
-   Simple Scan
-   GNOME Web / Epiphany

## W-LAN (Verbindungsprobleme beheben)

```bash
sudo echo "options iwlwifi 11n_disable=1" >> /etc/modprobe.d/iwlwifi.conf
```

## Synaptics Touchpad (Aktivieren und Deaktivieren)

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

## [ThinkVision LT1421](https://github.com/srw2d/tvlt1421_ubuntu) (Aktivieren und Deaktivieren)

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

## [Wacom Tablet](http://linuxwacom.sourceforge.net/wiki/index.php?title=Consumer_Tablet_ExpressKey_Mapping_Issue) (Funktionen der Tasten festlegen)

```bash
#!/bin/bash

xsetwacom set "Wacom Intuos PT S Pad pad" button 3 button "key ctrl z"
xsetwacom set "Wacom Intuos PT S Pad pad" button 1 button "key ctrl shift z"
xsetwacom set "Wacom Intuos PT S Pad pad" button 9 button "key plus"
xsetwacom set "Wacom Intuos PT S Pad pad" button 8 button "key minus"
```

## Andere Fehler

Nach Anmeldung ist für einige Minuten nur der Desktop zu sehen [Bug #1596377](https://bugs.launchpad.net/elementaryos/+bug/1596377)

```bash
sudo mv /etc/xdg/autostart/at-spi-dbus-bus.desktop /etc/xdg/autostart/at-spi-dbus-bus.disabled
```
