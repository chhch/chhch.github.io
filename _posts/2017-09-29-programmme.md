---
title: Systemkonfiguration
tags: [liste, elementary_os]
---

## Installierte Programme

- `sudo apt install software-properties-common htop ncdu curl ubuntu-restricted-extras bat`
- [Fish](https://fishshell.com/)
  - [Default Shell](https://fishshell.com/docs/current/index.html#default-shell) `chsh -s /usr/bin/fish`
  - Prompt `fish_config`
- [Git](https://git-scm.com/download/linux)
  - `git config --global user.name "chhch"`
  - `git config --global user.email "chhch@users.noreply.github.com"`
  - `chmod 600 ~/.ssh/id_rsa`
  - `chmod 600 ~/.ssh/config`
  - `ssh git@github.com`
- [nvm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm)
  - [Calling nvm use automatically in a directory with a .nvmrc file](https://github.com/nvm-sh/nvm#fish) ([Oh My Fish](https://github.com/oh-my-fish/oh-my-fish#installation), [bass](https://github.com/edc/bass))
- [Sdkman](https://sdkman.io/)
  - [Oh My Fish Plugin](https://github.com/deather/omf-sdk)
  - Java
- [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/) (replace `$(lsb_release -cs)` when installing)
  - [Manage Docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)
- [IntelliJ IDEA](https://github.com/JonasGroeger/jetbrains-ppa)
- [KeePassXC](https://keepassxc.org/download/) (Flatpak)
- [Déjà Dup](https://apps.gnome.org/de/app/org.gnome.DejaDup/) (Flatpak)
  - `touch .deja-dup-ignore`
- [Firefox](https://www.mozilla.org/de/firefox/new/) (Flatpak)
  - Allow access to home folder
- [Chrome](https://www.google.com/intl/de/chrome/browser/desktop/index.html)
  - uBlock Origin
  - Vimium [Settings]({{ site.baseurl }}{% link assets/misc/vimium-options.json %})
  - Dark Reader
  - LanguageTool
  - Google Übersetzer
  - [DuckDuckGo Einstellungen](https://duckduckgo.com/?key=3a073f8c7b36df078df401ed92f513b91d385309dc2fed15e2ebde48e0d79a1b1511dd0da387e53998036412ce9d09bf1283630098f29e90f6307dbd9b8fd2a4)
- [Spotify](https://www.spotify.com/de/download/linux/) (Flatpak)
- [Peek](https://github.com/phw/peek) (Flatpak)
- [Darkbar](https://github.com/bluesabre/darkbar) (Flatpak)
- [Monitor](https://github.com/stsdc/monitor)
- [Tresorit](https://tresorit.com/de/download) (before install `mkdir -p ~/.local/share/tresorit`)


## Troubelshooting

- [Night light not working](https://elementaryos.stackexchange.com/a/18670): `gsettings set org.gnome.system.location enabled true`
- [Application opens two icons in plank](https://elementaryos.stackexchange.com/a/20)
- [fprint](https://wiki.ubuntuusers.de/fprint/): <https://elementaryos.stackexchange.com/a/28319>
- Shortcuts not working
  - `sudo apt-get install dconf-editor && dconf-editor`
  - Remove all binding, which overrides shortcuts in `/org/gnome/desktop/wm/keybindings/` 
