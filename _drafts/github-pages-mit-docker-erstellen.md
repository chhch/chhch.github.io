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

## Jekyll

_Jeykll_ (v. 3.5.2) ermöglicht es aus Markdown-Dateien eine statische Webseite zu generieren. Neben den Markdown-Dateien, die den Inhalt der Seite enthalten, können weitere Konfigurations- und Layout-Dateien angegeben werden. Die Jekyll bei der Generierung ebenfalls berücksichtigt.

Wenn nicht anders konfiguriert, wird ein Jekyll-Projekt wie folgt angelegt:

```text
.
├── _config.yml (Konfiguration)
├── _data (Daten können hier als .yml, .yaml, .json oder .csv abgelegt werden)
|   └── social-media.yml
├── _drafts (Unveröffentlichte Beiträge können hier abgelegt werden)
|   └── github-pages-mit-jekyll-docker-image.md
├── _includes (Code-Teile die von Layouts wiederverwendet werden können)
|   ├── date.html
|   └── tags.html
├── _layouts (Templates, das Design der Seite)
|   ├── default.html
|   └── post.html
├── _posts (Die einzelnen Beiträge, also der Content der Seite)
|   ├── 2017-09-29-programmme.md
|   └── 2017-09-30-html5-grid-layout-und-flex.md
├── _sass (Sass-Datein die in eine einzige Stylesheet-Datei umgewandelt werden können)
|   ├── _base.scss
|   └── _layout.scss
├── _site (Die genierte Seite wird hier abgelegt)
├── index.html (Startseite)
├── other.md (http://example.com/other.html)
└── favicon.ico (Alle anderen Dateien und Ordner werden Eins-zu-eins in den _site-Ordner übernommen)
```

Daten können als YAML, JSON oder CSV in den Ordner `_data` abgelegt werden. Anschließend ist möglich auf die Daten über die Variable `site.data` zuzugreifen.

In dem Ordner `_drafts` sind unveröffentlichte Beiträge, ohne Datum, an denen noch gearbeitet wird. Mit dem Flag `--darfts` werden auch Drafts bei der Generierung der Seite berücksichtigt.

Der Inhalt von Dateien die in dem Ordner `_includes` liegen, können in andere Dateien geladen werden.

Beiträge in `_post` haben in der Regel eine YAML-Kopfzeile. Diese befindet sich am Anfang der Datei in YAML-Format und ist durch `---` begrenzt. In der Kopfzeile können beispielsweise der Titel, das Datum und die Tags des Posts festgelegt werden. Ansonsten übernimmt Jekyll das Datum und den Namen für den Posts aus dessen Dateinamen. Der Dateiname muss wie folgt aufgebaut sein: `YYYY-MM-DD-Titel.md`. Standardmäßig speichert Jekyll den ersten Absatz eines Beitrags automatisch in die Variable `post.excerpt`. Neben Tags lassen sich Beiträge auch Kategorien (categories) zuordnen. Anders als Tags haben Kategorien Einfluss auf die Ordnerstruktur der generierten Seite.

Jekyll kann aus Dateien mit der Endung `.sass` oder `.scss` automatisch die entsprechenden CSS-Dateien generieren. Wird die `@import`-Anweisung von Sass verwendet, müssen die importierten Dateien in den Ordner `_sass` abgelegt werden.

Die Markdown-Dateien werden mit [Kramdown](https://kramdown.gettalong.org/index.html) verarbeitet. Das Code-Highlighting erfolgt mit  [Rouge](http://rouge.jneen.net/). Soll die Seite über GitHub-Pages generiert werden, müssen diese Prozessoren verwendet werden.

Jekyll enthält Themes. Wird ein Themes von Jekyll verwendet müssen die Ordner `assets`, `_layouts`, `_includes` und `_sass` nicht selbst erstellt werden.

### Liquid

{% raw %}
Jekyll nutzt Liquid, um Templates zu verarbeiten. Liquid-Code kann in drei Kategorien eingeteilt werden: Objects, Tags und Filter.

_Objects_ sagen Liquid, wo Inhalt angezeigt werden soll. Objects und Variablen stehen innerhalb von zwei geschweiften Klammern, zum Beispiel `{{ page.title }}`.

_Filter_ ändern die Ausgabe eines Liquid-Objects. Filter werden durch ein `|` eingeleitet, die Anwendung von zwei Filter sieht wie folgt aus `{{ "adam!" | capitalize | prepend: "Hello " }}`.

Mit der Hilfe von _Tags_ können logische Ausdrücke und Kontrollstrukturen für Templats erstellt werden. Tags befinden sich innerhalb von zwei geschweiften Klammern und dem Prozentzeichen, zum Beispiel `{% if user %} Hello {{ user.name }}! {% endif %}`.

Es werden drei Varianten von Tags unterschieden: Kontrollstrukturen, Iterationen und Zuweisung. Es werden unter anderen die Kontrollstrukturen `if (else)` und `case/when` unterstützt. Iterationen können mit einer `for`-Schleife ausgeführt werden. Bei der Zuweisung wird einer Variable ein Wert zugewiesen.

Die Verwendung von Liquid kann zu unerwünschten Leerstellen führen, um dies zu verhindern, kann der Liquid-Code mit einem `-` ergänzt werden, zum Beispiel `{%- if user -%}`.
{% endraw %}

### Tags

Alle Standard Liquid-Tags und -Filter werden unterstützt. Zusätzlich fügt Jekyll noch einige Tags und Filter hinzu.

Codeblöcke innerhalb eines `highlight` und `endhighlight`-Tags werden auf der Seite entsprechend gerendert. Dem `highlight`-Tag können zwei Parameter mitgegeben werden. Der erste Parameter gibt die verwendete Sprache im Codeblock an. Der zweite Parameter `linenos` aktiviert die Zeilennummern. Mit `rougify list` können alle von Rouge unterstützten Sprachen angezeigt werden. Damit die Syntax korrekt hervorgehoben wird, müssen entsprechende CSS-Regeln vorhanden sind.

Wird der `link`-Tag verwendet, um auf Post, Pages, Collections oder Dateien zu verlinken, prüft Jekyll beim Bauen der Seite, ob alle Links gültig sind. Zum `link`-Tag können allerdings keine Filter hinzugefügt werden.

### Plugins

_GitHub Pages Gem_ (v. 157) erlaubt es nur Plugins und Einstellungen zu verwenden, die auch von GitHub Pages unterstützt werden. Daher müssen in der `_config.yml` nur noch die Plugins angegeben werden, die tatsächlich verwendet werden. Falls eine Github Project Page erstellt werden soll, sind einige zusätzliche Dinge bei der Verlinkung zu beachten.

Für das Erstellen eines _Atom (RSS) Feeds_, genügt es das Plugin `jekyll-feed` in die `_config.yml` einzutragen. Damit der Browser von dem Feed erfährt, kann `{% feed_meta %}` in den Head-Bereich der `default.html` hinzugefügt werden.

Das Plugin `jekyll-default-layout` wird von GitHub Pages Gem aktiviert. Es setzt automatisch ein Layout, falls in der YAML-Kopfzeile einer Markdown-Datei kein Layout angegeben wurde. Daher kann die Angabe zum Beispiele bei einem Posts wegelassen werden.

### Variablen

Jekyll setzt einige _Variablen_, die via Liquid abrufbar sind. Die Variablen können in drei Bereichen unterteilt werden: Global-, Site- und Page-Variablen. Zu den Global-Variable gehören unter anderem `page`, `layout` und `content`. Zu den Site- und Page-Variablen zählen alle Variablen die mit `page.*` bzw. `site.*` abgefragt werden können.

### Collection

Neben den Collections Posts und Pages können in Jekyll auch eigene _Collections_ erstellt werden. Es ist möglich, einen Namen und den Pfad zu einer Collection anzugeben. Für Posts wäre der Pfad beispielsweise `_post`. Weitere Einstellungen sind möglich, wie zum Beispiel das Festlegen eines Standard Layouts für die Dateien in der Collection/Ordner.

### Permalink

_Permalinks_ bestimmen den Aufbau der URLs (ohne Domainname und Pfad) für Posts, Pages und Collections. Jekyll erlaubt es für den Permalink ein Template anzugeben, dieser ist für Posts standardmäßig `/:categories/:year/:month/:day/:title.html`.

Jekyll bringt außerdem einige Templatestyles mit. Der Style `pretty` sorgt für folgende URL `/:categories/:year/:month/:day/:title/`. Beim Bauen der Seite erstellt Jekyll für jeden Post, Page und Collection einen Ordner mit dem Namen des Posts und fügt den Post als index.html in den Ordner, sodass der Post anschließend ohne `.html` in URL aufgerufen werden kann.
