---
title: GitHub-Pages mit Jekyll erstellen
tags: [bundler, jekyll]
---

_Jeykll_ (v. 3.5.2) ermöglicht es aus Markdown-Dateien eine statische Webseite zu generieren. Neben den Markdown-Dateien, die den Inhalt der Seite enthalten, können weitere Konfigurations- und Layout-Dateien angegeben werden. Die Jekyll bei der Generierung ebenfalls berücksichtigt.

## Bundler

Für die Verwaltung der Erweiterungen von Jekyll kann _Bundler_ (v. 1.15) verwendet werden. Bundler hilft nachzuvollziehen, auf welche Gems einschließlich ihrer Version das Projekt aufbaut. Damit nur die Gems verwendet werden, die auch GitHub-Pages zulässt, reicht es aus die [Github-Pages-Gem](https://github.com/github/pages-gem) in die Datei `Gemfile` einzufügen.

Mit dem Befehl `bundle install` werden die von GitHub-Pages untersützen Gems installiert. Anschließend erstellt Bundler die Datei `Gemfile.lock` in der die Versionen der installierten Gems und deren Abhängigkeiten enthalten sind. Das `Gemfile` zusammen mit dem `Gemfile.lock` liefern ein Abbild der verwendeten Gems und deren Versionen.

Beim erneuten Aufruf von `bundle install` prüft Bundler, ob alle benötigten Abhängigkeiten vorhanden sind. Außerdem vergleicht Bundler, ob die Versionen der Gems mit den Versionen aus der `Gemfile.lock` übereinstimmen. Falls keine Version im `Gemfile` angegeben wurde und bereits eine neuere Version vorhanden ist, wird die Version aus dem `Gemfile.lock` verwendet. Der Befehl `bundle install` aktualisiert nur Gems, wenn eine neue Version in dem `Gemfile` explizit festgelegt wurde.

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

Mit dem Befehl `bundle update [Gem]` kann eine Gem aktualisiert werden. Dazu ist die neue Version oder keine Version im `Gemfile` einzutragen. Bundler löst dann die Abhängigkeiten der Gem neu auf und ignoriert die Datei `Gemfile.lock`.

Die Ausführung von `bundle exec jekyll serve` sorgt dafür, dass beim Starten von Jekyll nur die Gems verwendet werden, die im `Gemfile` spezifiziert sind.

## Ordnerstruktur

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

Daten können als YAML, JSON oder CSV in den Ordner `_data` abgelegt werden. Anschließend ist es möglich auf die Daten über die Variable `site.data` zuzugreifen.

In dem Ordner `_drafts` sind unveröffentlichte Beiträge, ohne Datum, an denen noch gearbeitet wird. Mit dem Flag `--darfts` werden auch Drafts bei der Generierung der Seite berücksichtigt.

Der Inhalt von Dateien die in dem Ordner `_includes` liegen, können in andere Dateien geladen werden.

Beiträge in dem Ordner `_post` haben in der Regel eine YAML-Kopfzeile. Diese befindet sich am Anfang der Datei in YAML-Format und ist durch `---` begrenzt. In der Kopfzeile können beispielsweise der Titel, das Datum und die Tags des Posts festgelegt werden. Sonst übernimmt Jekyll das Datum und den Namen für den Posts aus dessen Dateinamen. Der Dateiname muss wie folgt aufgebaut sein: `YYYY-MM-DD-Titel.md`. Standardmäßig speichert Jekyll den ersten Absatz eines Beitrags automatisch in die Variable `post.excerpt`. Neben Tags lassen sich Beiträge auch Kategorien (categories) zuordnen. Anders als Tags haben Kategorien Einfluss auf die Ordnerstruktur der generierten Seite.

Jekyll kann aus Dateien mit der Endung `.sass` oder `.scss` automatisch die entsprechenden CSS-Dateien generieren. Wird die `@import`-Anweisung von Sass verwendet, sollten die importierten Dateien in den Ordner `_sass` abgelegt werden.

Die Markdown-Dateien werden mit [Kramdown](https://kramdown.gettalong.org/index.html) verarbeitet. Das Code-Highlighting erfolgt mit [Rouge](http://rouge.jneen.net/). Soll die Seite über GitHub-Pages generiert werden, sind diese Prozessoren zu verwenden.

Jekyll enthält verschiedene Themes. Wird ein Theme von Jekyll verwendet, müssen die Ordner `assets`, `_layouts`, `_includes` und `_sass` nicht selbst erstellt werden.

## Template erstellen mit Liquid

{% raw %}
Jekyll nutzt Liquid, um Templates zu verarbeiten. Liquid-Code kann in die drei Kategorien _Objects_, _Tags_ und _Filter_ eingeteilt werden.

Objects sagen Liquid, wo Inhalt angezeigt werden soll. Objects und Variablen stehen innerhalb von zwei geschweiften Klammern, zum Beispiel `{{ page.title }}`.

Filter ändern die Ausgabe eines Liquid-Objects. Filter werden durch ein `|` eingeleitet, die Anwendung von zwei Filtern, sieht wie folgt aus `{{ "adam!" | capitalize | prepend: "Hello " }}`.

Mit der Hilfe von Tags können logische Ausdrücke und Kontrollstrukturen für Templats erstellt werden. Tags befinden sich innerhalb von zwei geschweiften Klammern und dem Prozentzeichen, zum Beispiel `{% if user %} Hello {{ user.name }}! {% endif %}`.

Es werden drei Varianten von Tags unterschieden: Kontrollstrukturen, Iterationen und Zuweisung. Es werden unter anderen die Kontrollstrukturen `if (else)` und `case/when` unterstützt. Iterationen können mit einer `for`-Schleife ausgeführt werden. Bei der Zuweisung wird einer Variable ein Wert zugewiesen.

Die Verwendung von Liquid kann zu unerwünschten Leerstellen führen, um dies zu verhindern, kann der Liquid-Code mit einem `-` ergänzt werden, zum Beispiel `{%- if user -%}`.

## Jekyll spezifische Tags

Alle Standard Tags und Filter von Liquid werden unterstützt. Zusätzlich fügt Jekyll noch eigene Tags und Filter hinzu.

Codeblöcke innerhalb der Tags `{% highlight %}` und `{% endhighlight %}` werden auf der Seite als Quellcode ausgegeben. Der Tag `highlight` hat zwei optionale Parameter. Der erste Parameter gibt die verwendete Sprache im Codeblock an. Der zweite Parameter `linenos` aktiviert die Zeilennummern neben dem Quellcode. Mit `rougify list` können alle von Rouge unterstützten Sprachen angezeigt werden. Damit die Syntax korrekt hervorgehoben wird, müssen entsprechende CSS-Regeln vorhanden sein.

Wird der Tag `link` verwendet, um auf Post, Pages, Collections oder Dateien zu verlinken, prüft Jekyll beim Bauen der Seite, ob alle Links gültig sind. Zum Tag `link` können allerdings keine Filter hinzugefügt werden.

## Plugins

_GitHub-Pages-Gem_ (v. 157) erlaubt es nur Plugins und Einstellungen zu verwenden, die auch von GitHub-Pages unterstützt werden. In der `_config.yml` sind Plugins explizit zu aktivieren, falls diese nicht standardmäßig aktiviert sind. Falls eine Github-Project-Page erstellt werden soll, sind einige zusätzliche Dinge bei der Verlinkung zu beachten.

Für das Erstellen eines _Atom (RSS) Feeds_, genügt es das Plugin `jekyll-feed` in die `_config.yml` einzutragen. Damit der Browser von dem Feed erfährt, kann `{% feed_meta %}` in den Head-Bereich der `default.html` hinzugefügt werden.

Das Plugin `jekyll-default-layout` wird von GitHub-Pages-Gem aktiviert. Es setzt automatisch ein Layout, falls in der YAML-Kopfzeile einer Markdown-Datei kein Layout angegeben wurde. Daher kann die Angabe zum Beispiele bei einem Posts wegelassen werden.

## Variablen

Jekyll setzt einige Variablen, die via Liquid abrufbar sind. Die Variablen können in drei Bereichen unterteilt werden: Global-, Site- und Page-Variablen. Zu den Global-Variable gehören unter anderem `page`, `layout` und `content`. Zu den Site- und Page-Variablen zählen alle Variablen die mit `page.*` bzw. `site.*` abgefragt werden können.

## Collection

Neben den _Collections_ Posts und Pages können in Jekyll auch eigene Collections erstellt werden. Es ist möglich, einen Namen und den Pfad zu einer Collection anzugeben. Für Posts wäre der Pfad beispielsweise `_post`. Weitere Einstellungen sind möglich, wie zum Beispiel das Festlegen eines Standard Layouts für die Dateien in der Collection bzw. in dem Ordner.

## Permalink

_Permalinks_ bestimmen den Aufbau der URLs (ohne Domainname und Pfad) für Posts, Pages und Collections. Jekyll erlaubt es für den Permalink ein Template anzugeben, dieser ist für Posts standardmäßig `/:categories/:year/:month/:day/:title.html`.

Jekyll bringt außerdem einige Templatestyles mit. Der Style `pretty` sorgt für folgende URL `/:categories/:year/:month/:day/:title/`. Beim Bauen der Seite erstellt Jekyll für jeden Post, jede Page und jede Collection einen Ordner mit dem Namen der Datei und fügt die Datei selbst als index.html in den Ordner, sodass die Datei anschließend ohne `.html` in URL aufgerufen werden kann.
{% endraw %}
