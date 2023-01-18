echo "Replace <Alt> with <Super>"
echo "[Keybinding] Fenster: Fenster verschieben"
gsettings get org.gnome.desktop.wm.keybindings begin-move
gsettings set org.gnome.desktop.wm.keybindings begin-move "['<Super>F7']"
echo "...replaced with ['<Super>F7']"
echo "[Keybinding] Fenster: Fenstergröße ändern"
gsettings get org.gnome.desktop.wm.keybindings begin-resize
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super>F8']"
echo "...replaced with ['<Super>F8']"
echo "[Keybinding] Navigation: Sofort zwischen den Anwendung einer Anwendung wechseln"
gsettings get org.gnome.desktop.wm.keybindings cycle-group
gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Super>F6']"
echo "...replaced with ['<Super>F6']"
echo "[Keybinding] Kein Eintrag in Einstellungen"
gsettings get org.gnome.desktop.wm.keybindings cycle-group-backward
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward "['<Shift><Super>F6']"
echo "...replaced with ['<Shift><Super>F6']"
echo "[Keybinding] System: Ausführen dialog anzeigen"
gsettings get org.gnome.desktop.wm.keybindings panel-run-dialog
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "['<Super>F2']"
echo "...replaced with ['<Super>F2']"
echo "[Keybinding] Fenster: Maximierungszustand ein-/ausschalten"
gsettings get org.gnome.desktop.wm.keybindings toggle-maximized
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>F10']"
echo "...replaced with ['<Super>F10']"
echo
echo "Remove unused keybindings with <Alt>"
echo "[Keybinding] Fenster: Fenstergröße wiederherstellen (remove <Alt>F5)"
gsettings get org.gnome.desktop.wm.keybindings unmaximize
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Super>Down']"
echo "...replaced with ['<Super>Down']"
echo "[Keybinding] Kein Eintrag in Einstellungen"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-up
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "[]"
echo "...replaced with []"
echo "[Keybinding] Kein Eintrag in Einstellungen"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-down
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "[]"
echo "...replaced with []"
echo "[Keybinding] Kein Eintrag in Einstellungen"
gsettings get org.freedesktop.ibus.panel.emoji unicode-hotkey
gsettings set org.freedesktop.ibus.panel.emoji unicode-hotkey "[]"
echo "...replaced with []"
echo "[Keybinding] Navigation: Fenster eine Arbeitsfläche nach unten verschieben"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-down
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "[]"
echo "...replaced with []"
echo "[Keybinding] Navigation: Fenster eine Arbeitsfläche nach oben verschieben"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-up
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "[]"
echo "...replaced with []"
echo "[Keybinding] Navigation: Fenster eine Arbeitsfläche nach links verschieben"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-left
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>Page_Up', '<Super><Shift><Alt>Left']"
echo "...replaced with ['<Super><Shift>Page_Up', '<Super><Shift><Alt>Left']"
echo "[Keybinding] Navigation: Fenster eine Arbeitsfläche nach rechts verschieben"
gsettings get org.gnome.desktop.wm.keybindings move-to-workspace-right
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>Page_Down', '<Super><Shift><Alt>Right']"
echo "...replaced with ['<Super><Shift>Page_Down', '<Super><Shift><Alt>Right']"
echo "[Keybinding] Navigation: Zur Arbeitsfläche nach links wechseln"
gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-left
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up', '<Super><Alt>Left']"
echo "...replaced with ['<Super>Page_Up', '<Super><Alt>Left']"
echo "[Keybinding] Navigation: Zur Arbeitsfläche nach rechts wechseln"
gsettings get org.gnome.desktop.wm.keybindings switch-to-workspace-right
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down', '<Super><Alt>Right']"
echo "...replaced with ['<Super>Page_Down', '<Super><Alt>Right']"
echo
echo "Add keybindings"
echo "[Keybinding] Starter: Persönlicher Ordner öffnen"
gsettings get org.gnome.settings-daemon.plugins.media-keys home
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>x']"
echo "...replaced with ['<Super>x']"
