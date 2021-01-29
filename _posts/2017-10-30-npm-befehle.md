---
title: NPM Befehle
tags: [liste, npm]
---

## Node Package Manager

- `npm init`
- `npm install [--save-dev] <package>`
  - Lokale Installation: Dateien werden in `./node_modules` des aktuellen Ordners oder eines darüber liegenden Ordners abgelegt
  - Globale Installation: Dateien werden in `/usr/local` abgelegt
- `npm uninstall <package>`
- `npm list --depth=0`
- `npm list <packages>` (Zeigt Abhängigkeiten)
- `npm outdated`
- `npm update`
- `npm install <package>@latest` (Updates major version)
- `npm doctor`

## Node Version Manager

- `nvm install node` (Installiert die aktuelle Version von Node)
- `nvm use node` (Aktuelle Version verwenden)
- `nvm alias default node` (Node Version, die beim Öffenen eines Terminals verwendet werden soll)
