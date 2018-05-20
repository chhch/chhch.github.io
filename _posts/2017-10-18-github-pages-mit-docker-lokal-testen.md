---
title: GitHub-Pages mit Docker lokal testen
tags: [docker, jekyll]
---

## Docker

[Docker](https://www.docker.com/ "Version 17.06.1-ce") ermöglicht es Anwendungen auszuführen. Die Besonderheit von Docker ist, dass die Anwendung innerhalb eines eigens auf sie zugeschnittenen _virtuellen Systems_ läuft. Das virtuelle System kann beliebig bzw. den Anforderungen entsprechend konfiguriert werden. Auf dem virtuellen System können zum Beispiel nur die Softwarepakete installiert werden, die eine Anwendung wie [Jekyll](https://jekyllrb.com/ "Version 3.5.2") benötigt.

Ausgeführt werden die _Images_ der Betriebssysteme durch _Container_. Die Konfiguration eines Images erfolgt mit der Hilfe einer Textdatei, die den Namen _Dockerfiles_ trägt. Images können als Grundlage für andere Images dienen.

Für Jekyll existieren bereits zahlreiche Konfigurationen. Das offizielle Image befindet sich auf [Docker Hub](https://hub.docker.com/r/jekyll/jekyll/ "Version 3.5.2"), das zugehörige Dockerfile kann auf [GitHub](https://github.com/envygeeks/jekyll-docker/blob/01abc93de8271a512b47b5b058e653c153591b2c/repos/jekyll/Dockerfile "Version 3.5.2") eingesehen werden.

## Jekyll-Container starten

Mit dem nachfolgenden Befehl ist es möglich, eine Seite mit Jekyll zu bauen und in einem lokalen Server auszuliefern.

```shell
docker run --rm \
  --mount type=bind,source=/host/pfad/zur/jekyll/seite,target=/srv/jekyll \
  --publish 80:4000 \
  --name jekyll \
  jekyll/jekyll:3.5.2 \
  jekyll serve
```

Ein Container kann alternativ auch mit [Docker-Compose](https://docs.docker.com/compose/ "Version 1.15.0") gestartet werden. Statt die Parameter der Anweisung `docker run` anzufügen, werden sie in die Datei `docker-compose.yml` geschrieben. Gestartet wird der Container mit dem Befehl `docker-compose up`. Nachfolgend ist die `docker-compose.yml` für das Bauen einer Jekyll-Seite beschrieben.

```yaml
version: "3.3"
services:
  jekyll_site:
    image: jekyll/jekyll:3.5.2
    command: jekyll serve
    volumes:
      - type: bind
        source: /host/pfad/zur/jekyll/seite
        target: /srv/jekyll
    ports:
      - published: 80
        target: 4000
```

Docker-Compose wird vor allem dafür verwendet, um Anwendungen mit mehreren Containern zu starten.

## Aufbau des Dockerfiles

Unten ist ein Ausschnitt aus dem [Jekyll-Dockerfile](https://github.com/envygeeks/jekyll-docker/blob/01abc93de8271a512b47b5b058e653c153591b2c/repos/jekyll/Dockerfile "Version 3.5.2") abgebildet. Nachfolgend werden die einzelnen Befehle kurz beschrieben.

```dockerfile
FROM ruby:alpine3.6
# ...
RUN gem install bundler
RUN gem install jekyll
# ...
CMD "jekyll --help"
WORKDIR /srv/jekyll
VOLUME /srv/jekyll
EXPOSE 35729
EXPOSE 4000
```

### Grundlage festlegen

Der Befehl `FROM` im Dockerfile gibt an, welches Image als Grundlage verwendet wird. Beispielsweise nutzt das Jekyll-Image das ruby-Image. Das ruby-Image bezieht sich wiederum auf das alpine-Image. Das alpine-Image verweist auf das scratch-Image. Die Reihenfolge ist unten abgebildet. In einem Dockerfile ist immer nur der direkte Vorgänger ersichtlich.

    +-------------------+
    | +---------------+ |
    | |    scratch    | |
    | +-------+-------+ |
    |         ^         |
    |         |         |
    | +-------+-------+ |
    | |    alpine     | |
    | +-------+-------+ |
    |         ^         |
    |         |         |
    | +-------+-------+ |
    | |     ruby      | |
    | +-------+-------+ |
    |         ^         |
    |         |         |
    | +-------+-------+ |
    | | jekyll/jekyll | |
    | +---------------+ |
    |                   |
    |    Host-System    |
    +-------------------+

Das scratch-Image ist ein leeres Image, welches von Docker bereitgestellt wird. Das alpine-Image verwendet [Alpine Linux](https://www.alpinelinux.org/), eine Linux-Distribution, die wenig Speicherplatz benötigt. Das ruby-Image sorgt dafür, dass Ruby korrekt installiert wird. Zuletzt wird im Jekyll-Image installiert. Die Images bauen aufeinander auf. Jedes Images muss nur einmal runtergeladen werden, und kann anschließend von anderen Images wiederverwendet werden.

### Befehle ausführen

Für das Ausführen von Anweisungen innerhalb des Containers können im Dockerfile die Befehle `RUN`, `CMD` und `ENTRYPOINT` verwendet werden. Der zuletzt genannte Befehl `ENTRYPOINT`, ist in dem Jekyll-Dockerfile nicht enthalten, wird aber der Vollständigkeit halber erwähnt.

Ein Dockerfile kann beliebig viele `RUN` aufrufe enthalten. Für jeden Aufruf von `RUN` wird ein neues Image erstellt, welches auf den vorherigen Aufruf aufbaut. Mit dem Befehl `docker image history <image>` wird die Historie der Images angezeigt. Die Images speichert Docker in einem Cache. Beim Instanziieren eines Images sucht Docker zunächst im Cache nach einem identischen Image, bevor es ein neues erstellt. Dies kann unter Umständen zu Problemen führen, wie das nachfolgende Beispiel zeigt. Gegeben ist der folgende Ausschnitt aus einem Dockerfile:

```dockerfile
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y curl
```

Beim Instanziieren wird für jedes `RUN` ein Image erstellt und im Cache gespeichert. Angenommen das Dockerfile wird folgendermaßen geändert:

```dockerfile
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y curl neuesPackage
```

Docker erkennt die Änderung in der dritten Zeile und führt `apt-get install -y curl neuesPackage` erneut aus. Allerdings wird der Befehl `apt-get update` nicht ausgeführt, da diese Zeile identisch mit der im Cache gespeicherten ist. Das führt dazu, dass der Befehl `apt-get update` nicht erneut ausgeführt wird, das Programm `neuesPackage` evtl. nicht vorhanden ist und `apt-get install` fehlschlägt. Daher wird empfohlen, die beiden Befehle immer zusammen auszuführen.

```dockerfile
RUN apt-get update && apt-get install -y \
  curl \
  nginx
```

Der Befehl `CMD` ermöglicht es ein Standard Befehl anzugeben, der ausgeführt wird, sobald der Container läuft. In Verbindung mit dem Befehl `ENTRYPOINT` kann zusätzlich ein Standard Parameter angegeben werden. Wird beim Starten des Containers ein Befehl bzw. Parameter angegeben, wird der Befehl `CMD` aus dem Dockerfile überschrieben.

Während `CMD` einen eher optionalen Charakter hat, dessen Wert bei bedarf überschrieben werden kann, soll `ENTRYPOINT` immer dann verwendet werden, wenn ein bestimmtes Programm mit ggf. festen Parametern ausgeführt wird.

Die Befehle können auf zwei Weisen dargestellt werden:

-   Shell-From: `RUN/CMD/ENTRYPOINT command param1 param2`
-   Exec-Form: `RUN/CMD/ENTRYPOINT ["executable", "param1", "param2"]`

Wobei Docker unterschiedlich verfährt. Die erste Variante wird in der Shell ausgeführt, die Zweite direkt im Terminal:

-   Shell-From: `/bin/sh -c command param1 param2`
-   Exec-Form: `executable param1 param2`

### Arbeitsverzeichnis wechseln

Der Befehl `WORKDIR` wird verwendet, um das Verzeichnis zu wechseln. Es können sowohl relative als auch absolute Pfade angegeben werden.

### Daten laden und speichern

Der Befehl `VOLUME` wird verwendet, um den Einhängepunkt von Datenbankdaten, Konfigurationen oder Dateien des Containers festzulegen. Das Host-Verzeichnis wird nicht im Dockerfile festgelegt, sondern erst bestimmt, wenn der Container gestartet wird.

Daten können im Container gespeichert werden. Die Daten würden aber verloren gehen, sobald der Container gelöscht wird. Außerdem ist es schwer, vom Host-System an die Daten zu gelangen. Einfacher ist es Daten oder ein Verzeichnis vom Host-System in den Container einzuhängen. Es werden drei Varianten unterschieden: _Volumes_, _Bind-Mounts_ und _tmpfs-Volumes_. Nach der Dokumentation von Docker sind Volumes meistens die beste Wahl. Unabhängig davon, welche Variante gewählt wird, werden die Daten im Container gleich angezeigt.

Die Varianten unterscheiden sich hinsichtlich des Orts, an dem die Daten gespeichert werden. Volumes sind Teil des Host-Dateisystems, welcher von Docker verwaltet wird und sich unter `var/lib/docker/volumes/` befindet. Die Daten sollten nicht außerhalb eines Docker-Prozesses verändert werden. Bind-Mounts erlauben es Daten sowohl außerhalb von Docker zu bearbeitet als auch überall im Host-System zu speichern. Tmpfs-Mounts werden nur im Speicher des Host-Sytems geschrieben und nie in das Dateisystem verschoben.

    +-----------------+    +-----------------+
    |   Dateisystem   |    |    Speicher     |
    |                 |    |                 |
    | +-------------+ |    | (tmpfs-Volumes) |
    | | Docker-Area | |    +-----------------+
    | |             | |
    | |  (Volumes)  | |
    | +-------------+ |
    |                 |
    |  (Bind-Mounts)  |
    +-----------------+

Für das Einhängen eines Laufwerks können dem Befehl `docker run` sowohl das `-v` als auch das `--mount` Flag angefügt werden. Letzteres wird empfohlen, da die `--mount`-Syntax aussagekräftiger ist. Sie besteht unter anderen aus folgenden Key-Value-Paaren:

-   `type`: Variante, wie die Daten eingehängt werden. Entweder `bind`, `volume` oder `tmpfs`.
-   `source`/`src`: Pfad zu der Datei oder dem Ordner des Host-Systems die eingehängt werden sollen.
-   `destination`/`dst`/`target`: Pfad zu der Datei oder dem Ordner, der im Container eingehängt wird.
-   `readonly`: Falls Bind-Mount, kann im Container auf die eingehängten Daten nur lesend zugegriffen werden.

### Ports öffnen

Mit `EXPOSE` werden die Ports angegeben, auf die ein Container zur Laufzeit lauscht. Ports werden durch den Befehl nicht für die Host geöffnet. Der Host kann auf diese Ports erst zugreifen, wenn er den entsprechenden Port beim Ausführen des Containers mit dem Flag `-P` bzw. `--publish` gesetzt hat.
