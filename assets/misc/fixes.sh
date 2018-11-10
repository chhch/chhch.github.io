# W-LAN (Verbindungsprobleme beheben)
sudo echo "options iwlwifi 11n_disable=1" >> /etc/modprobe.d/iwlwifi.conf

# Nach Anmeldung ist für einige Minuten nur der Desktop zu sehen
# [Bug #1596377](https://bugs.launchpad.net/elementaryos/+bug/1596377)
sudo mv /etc/xdg/autostart/at-spi-dbus-bus.desktop /etc/xdg/autostart/at-spi-dbus-bus.disabled
