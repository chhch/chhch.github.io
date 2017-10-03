---
title: GitHub Pages mit Docker lokal testen
tags: [docker, bundler, jekyll]
---

## Docker

Docker (v. 17.06.1-ce) ermöglicht es Anwendungen auszuführen. Die Besonderheit von Docker ist, dass die Anwendung innerhalb eines eigens auf sie zugeschnittenen _virtuellen Systems_ läuft. Das virtuelle System ist unabhängig vom System des Nutzers und kann beliebig bzw. den Anforderungen entsprechend konfiguriert werden.

Arbeitet der Nutzer beispielsweise mit einem Windows-System, kann in dem virtuellen System trotzdem Ubuntu als Betriebssystem zum Einsatz kommen. Auf dem virtuellen Ubuntu-System können dann die Softwarepakete installiert werden, die zum Beispiele eine Anwendung wie Jekyll benötigt. Unten ist das Beispiel grafisch dargestellt.

    +---------------------------------------------------+
    |                                                   |
    |             +----------------------------------+  |
    |             |                                  |  |
    |             |                   +-----------+  |  |
    | Host System | Virtuelles System | Anwendung |  |  |
    |             |                   |           |  |  |
    |  (Windows)  |     (Ubuntu)      | (Jekyll)  |  |  |
    |             |                   +-----------+  |  |
    |             |                                  |  |
    |             +----------------------------------+  |
    |                                                   |
    +---------------------------------------------------+

### Begriffe

Ausgeführt werden die Betriebssystem _Images_ durch _Container_. Die Konfiguration eines Images erfolgt mit der Hilfe einer Textdatei, die den Namen _Dockerfiles_ trägt. Images können als Grundlage für andere Images dienen.

Für Jekyll existieren bereits zahlreiche Konfigurationen. Das offizielle Image befindet sich auf [Docker Hub](https://hub.docker.com/r/jekyll/jekyll/), das zugehörige **aktuelle** Dockerfile kann auf [GitHub](https://github.com/jekyll/docker/blob/master/repos/jekyll/Dockerfile) eingesehen werden.

### Dockerfile

#### FROM

Der Befehl `FROM` im Dockerfile gibt an, welches Image als Grundlage verwendet wird. Beispielsweise nutzt das Jekyll-Image das ruby-Image. Das ruby-Image bezieht sich wiederum auf das alpine-Image. Das alpine-Image verweist auf das scratch-Image. Die Reihenfolge ist unten abgebildet.

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

Das scratch-Image ist ein leeres Image, welches von Docker bereitgestellt wird. Das alpine-Image verwendet [Alpine Linux](https://www.alpinelinux.org/), eine Linux-Distribution, die wenig Speicherplatz benötigt. Das ruby-Image sorgt dafür, dass Ruby korrekt installiert wird. Zuletzt wird im Jekyll-Image Jekyll (v. 3.5.2) installiert. Die Images bauen aufeinander auf. Jedes Images muss nur einmal runtergeladen werden, und kann anschließend von anderen Images wiederverwendet werden.

#### RUN, CMD und ENTRYPOINT

Unten ist ein Ausschnitt des Jekyll-Dockerfiles beschrieben. Neben dem oben beschriebenen `FROM`-Befehl enthält das Dockerfile noch andere Ausdrücke. Für das Ausführen von Befehlen innerhalb des Containers können im Dockerfile die Befehle `RUN`, `CMD` und `ENTRYPOINT` verwendet werden. Der zuletzt genannte Befehl `ENTRYPOINT`, ist in dem Jekyll-Dockerfile nicht enthalten, wird aber der vollständigkeitshalber erwähnt.

```dockerfile
FROM ruby:alpine3.6
# ...
RUN gem install bundler
RUN gem install jekyll
# ...
CMD "jekyll --help"
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
```

Ein Dockerfile kann beliebig viele `RUN` aufrufe enthalten. Für jeden Aufruf von `RUN` wird ein neues Image erstellt, welches auf den vorherigen Aufruf aufbaut. Mit dem Befehl `docker image history <image>` kann die Historie eines Images angezeigt werden. Diese Images speichert Docker in einem Cache. Beim erneuten Bauen eines Images sucht Docker zunächst im Cache nach einem identischen Image, bevor es ein neues erstellt. Dies kann unter Umständen zu Problemen führen, wie das nachfolgende Beispiel zeigt. Gegeben ist der folgende Ausschnitt aus einem Dockerfile:

```dockerfile
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y curl
```

Beim Bauen wird für jeden Befehl ein Image erstellt und im Cache gespeichert. Angenommen das Dockerfile wird folgendermaßen geändert:

```dockerfile
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y curl neuesPackage
```

Docker erkennt die Änderung in der dritten Zeile und führt `apt-get install -y curl neuesPackage` erneut aus. Allerdings wird der Befehl `apt-get update` nicht ausgeführt, da diese Zeile identisch mit der im Cache gespeicherten ist. Das führt dazu, dass das Programm `neuesPackage` evtl. nicht vorhanden ist und `apt-get install` fehlschlägt. Daher wird empfohlen, die beiden Befehle immer zusammen auszuführen.

```dockerfile
RUN apt-get update && apt-get install -y \
  curl \
  nginx
```

Der Befehl `CMD` ermöglicht es ein default Befehl anzugeben, der ausgeführt wird, sobald der Container läuft. In Verbindung mit `ENTRYPOINT` kann zusätzlich ein default Parameter angegeben werden. Wird beim Starten des Containers ein Befehl bzw. Parameter angegeben, wird der `CMD`-Befehl aus dem Dockerfile überschrieben.

Während `CMD` einen eher optionalen Charakter hat, dessen Wert bei bedarf überschrieben werden kann, soll `ENTRYPOINT` immer dann verwendet werden, wenn ein bestimmtes Programm mit ggf. festen Parametern ausgeführt werden soll.

Die Befehle können auf zwei Weisen dargestellt werden:

-   Shell-From: `RUN/CMD/ENTRYPOINT command param1 param2`
-   Exec-Form: `RUN/CMD/ENTRYPOINT ["executable", "param1", "param2"]`

Wobei Docker unterschiedlich verfährt:

-   Shell-From: /bin/sh -c command param1 param2
-   Exec-Form: executable param1 param2

#### WORKDIR

Der Befehl `WORKDIR` wird verwendet, um das Verzeichnis zu wechseln. Es können sowohl relative als auch absolute Pfade angegeben werden.

#### EXPOSE

Mit `EXPOSE` werden die Ports angegeben, auf die ein Container zur Laufzeit lauscht. Er ist optional und dient eher als Dokumentation, welche Ports genutzt werden. Ports werden durch den Befehl weder gemappt oder geöffnet. Der Host kann auf diese Ports erst zugreifen, wenn er den entsprechenden Port beim Starten mit dem `-P` Flag gesetzt hat.

#### VOLUME

Der Befehl `VOLUME` wird verwendet, um den Einhängepunkt von Datenbankdaten, Konfigurationen oder Dateien des Containers festzulegen. Das entsprechende Host-Verzeichnis wird nicht im Dockerfile festgelegt, sondern erst bestimmt, wenn der Container gestartet wird.

Daten können in den Container gespeichert werden. Die Daten würden aber verloren gehen, sobald der Container gestoppt wird. Es ist schwer an die Daten zu gelangen. Einfacher ist es Daten vom Host in den Container einzuhängen. Es werden drei Varianten unterschieden: _Volumes_, _Bind-Mounts_ und _tmpfs-Volumes_. Nach der Dokumentation von Docker sind Volumes meistens die beste Wahl. Unabhängig davon, welche Variante gewählt wird, werden die Daten im Container immer gleich angezeigt.

Die Varianten unterscheiden sich hinsichtlich des Orts, an dem die Daten gespeichert werden. Volumes sind Teil des Host-Dateisystems, welcher von Docker verwaltet wird, unter Linux `var/lib/docker(volumes/`. Die Daten sollten nicht außerhalb eines Docker-Prozesses verändert werden. Bind-Mounts können außerhalb von Docker bearbeitet werden und können überall im Host-System gespeichert werden. Tmpfs-Mounts werden nur im Speicher des Host-Sytems geschrieben und nie in das Dateisystem verschoben.

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

Für das Einhängen eines Laufwerks können sowohl das `-v` als auch das `--mount` Flag genutzt werden. Letzteres wird empfohlen, da die `--mount`-Syntax aussagekräftiger ist. Sie besteht unter anderen aus folgenden Key-Value-Paaren:

-   `type`: Variante, wie die Daten eingehängt werden. Entweder `bind`, `volume` oder `tmpfs`.
-   `source`/`src`: Pfad zu der Datei oder den Ordner des Host-Systems die eingehängt werden sollen.
-   `destination`/`dst`/`target`: Pfad zu der Datei oder den Ordner, der im Container eingehängt wird.
-   `readonly`: Falls beim Bind-Mount gesetzt, kann im Container auf die eingehängten Daten nur lesend zugegriffen werden.

### Container starten mit Docker

Mit dem nachfolgenden Befehl ist es möglich, eine Seite mit Jekyll zu bauen und in einem lokalen Server auszuliefern.

```shell
docker run --rm \
  --mount type=bind,source=/host/pfad/zur/jekyll/seite,target=/srv/jekyll \
  -p 127.0.0.1:80:4000 \
  jekyll/jekyll:3.5.2 \
  jekyll serve
```

### Container starten mit Docker-Compose

Ein Container kann alternativ auch mit Docker-Compose (v. 1.15.0) gestartet werden. Statt die Parameter der `docker run`-Anweisung anzufügen, werden sie in die Datei `docker-compose.yml` geschrieben. Gestartet wird der Container mit dem Befehl `docker-compose up`. Nachfolgend ist die `docker-compose.yml` für das Bauen einer Jekyll-Seite beschrieben.

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

Docker-Compose wird vor allem dafür verwendet, um Anwendungen mit mehre Container zu starten.

## Bundler

Für die Verwaltung der Erweiterungen von Jekyll kann _Bundler_ (v. 1.15) verwendet werden. Bundler hilft dabei, nachzuvollziehen, welche Gems einschließlich ihrer Version im Projekt genutzt werden. Damit nur die Gems verwendet werden, die auch GitHub-Pages zulässt, reicht es aus die [github-pages-Gem](https://github.com/github/pages-gem) in die Datei `Gemfile` einzufügen.

Mit dem Befehl `bundle install` werden die von GitHub-Pages untersützen Gems installiert. Anschließend erstellt Bundler die Datei `Gemfile.lock` in der die Versionen der installierten Gems und deren Abhängigkeiten enthalten sind. Das `Gemfile` zusammen mit dem `Gemfile.lock` liefern ein Abbild der verwendeten Gems und deren Versionen.

Beim erneuten Aufruf von `bundle install` prüft Bundler, ob alle benötigten Abhängigkeiten vorhanden sind und überspringt deren Installation bzw. prüft, ob alle Gems in der Version vorhanden sind, wie sie in der `Gemfile.lock` angegeben sind, selbst wenn keine Version im `Gemfile` angegeben wurde und bereits eine neuere Version vorhanden ist. Der Befehl `bundle install` updatet nur Gems, wenn eine neue Version in dem `Gemfile` explizit angegeben wurde.

Das oben beschriebene Vorgehen von `bundle install` wurde nachfolgend schematisch dargestellt.

    ●Start+--->bundle install
                     +
                     |
                     v
       [nein]  #Gemfile.lock
       +------+  vorhanden?
       |             +
       |             |[ja]
       |             v
       |      Gems u. Versionen
       |      aus Gemfile.lock
       |        installieren
       |             +
       |             |
       |             v
       |      #Neuere Versionen   [nein]
       |      im Gemfile explizit+-----+
       |          angegeben?           |
       |             +                 |
       |             |[ja]             |
       |             v                 |
       +------------>#                 |
                     +                 |
                     |                 |
                     v                 |
              (Neue) Versionen         |
                aus Gemfile            |
               installieren            |
                     +                 |
                     |                 |
                     v                 |
                Installierte           |
                Versionen in           v
                Gemfile.lock +-------->#+->◉Ende
                 schreiben

Sollen Gems aktualisiert werden, bei denen keine Version im `Gemfile` angegeben wurde, kann dies durch den Befehl `bundle update github-pages` erreicht werden. Wird kein Gem bei dem Update-Befehl angegeben, löst Bundler die Abhängigkeiten aller Gems neu auf und ignoriert die Datei  `Gemfile.lock`.

Die Ausführung von `jekyll serve` über `bundle exec` sorgt dafür, dass nur die Gems verwendet werden, die im `Gemfile` spezifiziert sind.

