---
title: Systemkonfiguration
tags: [liste, fedora]
---

## Installierte Programme

- `sudo dnf install htop ncdu bat`
- Settings
    - Power ➡ Screen Blank: `10 Minutes`
      - Displays ➡ Nicht Light: `on`
    - Mouse and Touchpad ➡ Touchpad ➡ Tap to Click: `on`
    - Keyboard ➡ Input Sources ➡ English (intl., with AltGr dead keys)
    - Keyboard ➡ Keyboad Shortcuts
        - [Set Gnome Keybindings]({{ site.baseurl }}{% link assets/misc/set-gnome-keybindings.sh %})
        - Terminal: <kbd>Super</kbd> + <kbd>T</kbd>: `kgx`
        - Emojis: <kbd>Super</kbd> + <kbd>E</kbd>: `gnome-characters`
    - Users ➡ Fingerprint login ➡ `on`
- [Flathub](https://flatpak.org/setup/Fedora)
    - [Déjà Dup](https://apps.gnome.org/de/app/org.gnome.DejaDup/)
    - [Extension Manager](https://github.com/mjakeman/extension-manager)
      - [Night Theme Switcher](https://extensions.gnome.org/extension/2236/night-theme-switcher/)
    - [Spotify](https://docs.fedoraproject.org/en-US/quick-docs/installing-spotify/#_installing_spotify_using_flatpak)
- [fish](https://fishshell.com/)
    - `chsh -s $(which fish)` set fish as [default shell](https://fishshell.com/docs/current/index.html#default-shell);
      login again
    - `fish_config`
- [1Password](https://1password.com/de/downloads/linux/)
    - [Turn on the 1Password SSH Agent](https://developer.1password.com/docs/ssh/get-started/#step-3-turn-on-the-1password-ssh-agent)
    - [Configure Git commit signing with SSH](https://developer.1password.com/docs/ssh/git-commit-signing#step-1-configure-git-commit-signing-with-ssh)
    - `git config --global user.name "chhch"`
    - `git config --global user.email "chhch@users.noreply.github.com"`
    - `ssh git@github.com`
- [JetBrains Toolbox App](https://www.jetbrains.com/toolbox-app/)
    - `fish_add_path ~/.local/share/JetBrains/Toolbox/scripts`
- [nvm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm#using-a-node-version-manager-to-install-nodejs-and-npm)
    - [Calling nvm use automatically in a directory with a .nvmrc file](https://github.com/nvm-sh/nvm#fish) ([Oh My Fish](https://github.com/oh-my-fish/oh-my-fish#installation)
      , [bass](https://github.com/edc/bass))
- [sdkman](https://sdkman.io/)
    - [Oh My Fish Plugin](https://github.com/deather/omf-sdk)
    - `sdk install java`
- [Docker](https://docs.docker.com/engine/install/fedora/)
    - [Post-installation steps for Linux](https://docs.docker.com/engine/install/linux-postinstall/)
- [Chrome](https://www.google.com/intl/de/chrome/browser/desktop/index.html)
- [OpenH264](https://docs.fedoraproject.org/en-US/quick-docs/openh264/), Hardware Acceleration for Firefox ([1](https://fedoraproject.org/wiki/Firefox_Hardware_acceleration). [2](https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration))
