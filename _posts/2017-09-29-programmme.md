---
title: Systemkonfiguration
tags: [liste, elementary_os]
---

## Installierte Programme

- [Git](https://git-scm.com/download/linux)
  - `git config --global user.name "chhch"`
  - `git config --global user.email "chhch@users.noreply.github.com"`
- [nodejs (npm) / nvm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm)
- [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
- docker-compose (Skript)
- [direnv](https://github.com/direnv/direnv) (Ubuntu)
- htop (Ubuntu)
- ncdu (Ubuntu)
- [KeePassXC](https://launchpad.net/~phoerious/+archive/ubuntu/keepassxc) (Flatpak)
- Datensicherung: Déjà Dup (Flatpak)
  - Sichern: `~`
  - Ignorieren: `Papierkorb`, `~/Downloads`, `~/.cache`
- Deutsche Rechtschreibprüfung: hunspell-de-de (Ubuntu)
- [Chrome](https://www.google.com/intl/de/chrome/browser/desktop/index.html) (DEB)
  - uBlock Origin
  - Google Übersetzer
  - LanguageTool
  - Hypothesis - Web & PDF Annotation
  - Mendeley Importer
- Firefox (AppCenter)
  - uBlock Origin
  - Cookie AutoDelete
  - LanguageTool
  - Privacy Badger
  - Toggle Referrer
- [Visual Studio Code](https://code.visualstudio.com/Download) (DEB)
  - [Settings Sync](https://github.com/shanalikhan/code-settings-sync)
- [Peek](https://code.launchpad.net/~peek-developers/+archive/ubuntu/stable) (Flatpak)
- Krita (Flatpak)
- [Mark Text](https://marktext.app/) (Flatpak)
- Disk Usage Analyzer aka BaoBab (Flatpak)

## Entfernte Programme

- Simple Scan
- GNOME Web / Epiphany

## Skripte

- [Synaptics Touchpad]({{ site.baseurl }}{% link assets/misc/synaptics-touchpad.sh %})
- [Wacom Tablet]({{ site.baseurl }}{% link assets/misc/wacom-tablet.sh %})
- [Bugfixes]({{ site.baseurl }}{% link assets/misc/fixes.sh %})
- Add `export GTK_IM_MODULE="xim"` to `.profile` to disable <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd> Shortcut
