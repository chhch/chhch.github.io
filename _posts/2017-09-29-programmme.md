---
title: Systemkonfiguration
tags: [liste, elementary_os]
---

## Installierte Programme

- Erlaube Repositories hinzuzufügen: `sudo apt install software-properties-common`
- `sudo apt install htop`
- `sudo apt install ncdu`
- `sudo apt install curl`
- [Fish](https://fishshell.com/)
  - [Fisch als default Shell einstellen](https://fishshell.com/docs/current/tutorial.html#switching-to-fish): (`chsh -s usr/bin/fish`)
  - Prompt ausählen: `fish_config`
- [Git](https://git-scm.com/download/linux)
  - `git config --global user.name "chhch"`
  - `git config --global user.email "chhch@users.noreply.github.com"`
- Keys nach `~/.ssh` kopieren
  - Berechtigung setzen: `chmod 600 ~/.ssh/id_rsa`
  - Berechtigung setzen: `chmod 600 ~/.ssh/config`
  - Hinzufügen `ssh-add ~/.ssh/id_rsa`
  - Testen mit `ssh git@github.com`
- [NodeJS (npm) / nvm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm)
  - [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish#installation)
  - [bass](https://github.com/edc/bass)
  - [Erstelle `~/.config/fish/functions/nvm.fish`](https://github.com/nvm-sh/nvm#fish)
- [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
  - [fish: Ersetze `$(lsb_release -cs)` durch den Namen der entsprechenden Ubuntu Version.]
  - [Docker ohne `sudo` nutzen](https://docs.docker.com/engine/install/linux-postinstall/)
- [Docker Compose](https://docs.docker.com/compose/install/) (Skript)
  - [fish: Entferne `"` und `$`.]
- [KeePassXC](https://keepassxc.org/download/) (DEB)
- [Tresorit](https://tresorit.com/de/download)
  - Vor dem Ausführend des Skripts `tresorit_installer.run` den Ordner `~/.local/share/tresorit` erstellen!
- Déjà Dup (Flatpak)
  - Sichern: `~`
  - Ignorieren: `Papierkorb`, `~/Downloads`, `~/.cache`
  - Ggf. `touch .cache/deja-dup/metadata`
  - Um Ordner wie `node_modules` zu ignorieren, erstelle in den jeweiligen Ordner eine Datei mit dem Namen `CACHEDIR.TAG` oder `.deja-dup-ignore`
- [Chrome](https://www.google.com/intl/de/chrome/browser/desktop/index.html) (DEB)
  - uBlock Origin
  - Vimium [Settings]({{ site.baseurl }}{% link assets/misc/vimium-options.json %})
  - Dark Reader
  - LanguageTool
  - Google Übersetzer
  - Bookmarkie - Bookmarks in a popup
  - Mendeley Importer
  - [DuckDuckGo Einstellungen](https://duckduckgo.com/?key=3a073f8c7b36df078df401ed92f513b91d385309dc2fed15e2ebde48e0d79a1b1511dd0da387e53998036412ce9d09bf1283630098f29e90f6307dbd9b8fd2a4)
- Fonts
  - [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
  - [Fira Code](https://github.com/tonsky/FiraCode)
- [Visual Studio Code](https://code.visualstudio.com/Download) (DEB)
- [Spotify](https://www.spotify.com/de/download/linux/) (Flatpak)
- [Peek](https://github.com/phw/peek) (Flatpak)
- [Monitor](https://github.com/stsdc/monitor)
- [Darkbar](https://github.com/bluesabre/darkbar) (AppCenter)


## Troubelshooting

- Mediacodecs: `sudo apt install ubuntu-restricted-extras`, ggf. [Mixer](https://github.com/childishgiant/mixer), um Volumen von Videos zu steuern, ggf. [weitere Codecs](https://wiki.ubuntuusers.de/Codecs/#Manuelle-Codec-Installation) https://github.com/elementary/videos/pull/285#issuecomment-993949262

night light/mode not working: https://elementaryos.stackexchange.com/a/18670 ➡️ `gsettings set org.gnome.system.location enabled true`

application opens two icons in plank https://elementaryos.stackexchange.com/a/20


https://elementaryos.stackexchange.com/a/28319
https://wiki.ubuntuusers.de/fprint/

	
Geometric Weather
https://play.google.com/store/apps/details?id=wangdaye.com.geometricweather