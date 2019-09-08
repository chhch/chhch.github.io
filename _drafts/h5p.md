---
title: H5P Entwicklung
tags: [h5p]
---

# H5P Development

## Miscellaneous

```javascript
H5P.externalDispatcher.on('xAPI', function (event) {
  console.log(event.data.statement);
});
```

Alle xAPI-Statements in der Konsole ausgeben.

```javascript
H5P.externalDispatcher.on('xAPI', function (event) {
if (event.data.statement.object.definition.name) {
  console.log('definition: ' + event.data.statement.object.definition.name['en-US']);
} else {
  console.log('definition: ' + event.data.statement.object.definition.description['en-US']);

}
console.log('interactionType: ' + event.data.statement.object.definition.interactionType);
event.data.statement.object.definition;
  console.log('verb: ' + event.data.statement.verb.display['en-US']);
  !event.data.statement.result || console.log('result');
  !event.data.statement.result || console.log(event.data.statement.result);
  console.log('');
});
```

## To do

- Optional Enable Local Module, set Language under Configuration → Language

## Development

- Use in Drupal, WordPress or Moodle
- Standalone 
  - [https://github.com/h5p/h5p-cli](https://github.com/h5p/h5p-cli)
  - [https://github.com/tunapanda/h5p-standalone](https://github.com/tunapanda/h5p-standalone)
    - [https://www.knanthony.com/blog/hosting-h5p-content-on-your-own](https://www.knanthony.com/blog/hosting-h5p-content-on-your-own)

## Reuse Content

- H5P download/upload file: copy from one site to another
- H5P copy/paste: copy within an H5P site, uses special per site clipboard

[https://h5p.org/node/442225](https://h5p.org/node/442225)

## Update

[https://h5p.org/post-hub-releases](https://h5p.org/post-hub-releases)

## Entwicklungsumgebung

H5P Inhalte können mit einen der Unterstützen Systemen Moodle, Wordpress und Drupal getestet werden oder mit einem Kommandozeilenprogramm welches über npm bezogen werden kann. Auf der H5P Seite wird die Entwicklung mit Drupal 7 empfohlen, da das H5P Plugin für Drupal ein extra _Developer Mode_ der automatisch die H5P Inhalte bei jedem Seiten-Request neulädt.

### Entwicklung mit h5p-cli

Die Ordnerstruktur muss wie folgt aussehen.

```
.
├── h5p-content
│   ├── content // mehrere Inhaltsordner möglich
│      ├── content.json
│      └── earth.jpg
├── h5p-libs
│   └── ...
└── h5p-server.json
```

Gestartet werden kann ein lokaler Server mit `h5p server h5p-server.json`. Der Befehl muss im Verzeichnis ausgeführt werden.

## Vorgehen

Ein H5P Inhalt besteht im einfachsten Fall aus einem content Ordner, der Komponente (hier H5P.GreetingCard) und einer h5p.json Datei.

```
h5p-libs (0)
├── [andere H5P-Bibliotheken] (0)
├── content (6)
│   ├── content.json
│   └── earth.jpg
├── H5P.GreetingCard
|   ├── language (5)
|   |   └── en.json
│   ├── greetingcard.css (4)
│   ├── greetingcard.js (3)
│   ├── library.json (1)
│   └── semantics.json (2)
└── h5p.json (7)
```

1. Metadaten spezifizieren (library.json)
2. Datenmodell beschreiben (semantic.json)
3. Code für die Komponente erstellen (greetingcard.js)
4. CSS für die Komponente definieren (greetingcard.css)
5. Übersetzung erstellen (language)
6. Inhalt erstellen (content)
7. H5P Datei Informationen

### Schritt 0 - Vorbereitung

Als erstes wird der Ordner angelegt und, falls benötigt, andere H5P-Bibliotheken runtergeladen.

### Using Other libraries [TODO: In einen Abschnitt zusammenfassen]

* how to use H5P libs in your custom lib
* update semantics
  * type: library, options
* invoke an resize the task library
  * H5P.newRunnable in Constructor
  * attach to DOM in attach-Fkt

### Schritt 1 - Metadaten spezifizieren (library.json)

`machineName` should match the folder name
`patchVersion` needs to be increased between uploads unless H5P framework is set in _development mode_ see Drupal.

### Using full-screen

1. library.jsonL fullscreen: 1
   or
2. Full-screen button + use of H5P full screen API

### Content Upgrade

* Why: new versions of a library may introduce new content Structure
* How: Provide an **upgrade script** that upgrades existing content created for previous versions

## Schritt 2 - Datenmodell beschreiben (semantic.json)

In der `sematic.json` wird beschrieben, welche Daten in der H5P-Komponente verwendet werden und wie sie im Autoren-Editor angezeigt und eingegeben werden sollen. **Der Editor wird daraus automatisch erstellt.**

Für die Eingabe können für verschiedenen Datentypen passende HTML-Elemente genutzt werden. Darüber hinaus ist es möglich _Widgets_ zu verwenden, die beliebige HTML-Inhalte darstellen können, wie z.B. ein Farbauswahl-Element, der die Auswahl eines HEX-Farbcodes ermöglicht.

To create and use a widget, following steps are needed

1. Create the editor widget library
   * create library.json, use H5PEditor namespace
2. Create the code skeleton
   * H5PEditor.widgets, Constructor
3. Create code for creating the visual part of the widget
   * appendTo
4. Create code for doing validation and saving
   * validate, remove
5. Configuring a content type for use the widget
   * Add an editor dependency in the content type's library.json
   * Update semantics.json to use the new widget

## Schritt 3 - Code für die Komponente erstellen (greetingcard.js)

* java-script to display content
* attached to the overall H5P object loaded by the framework
* provide a _attach_ method

### jQuery usage and integration

* H5P.jQuery (jQuery 1.9.1, current 3) to prevent namespace collisions
* jQuery UI is not included in H5P but available as an H5P library

### Using Event Dispatcher

* communication between instances of different classes
* the event system in H5P is not the same as the JavaSCript DOM Events
* see H5P.EventDispatcher

### Working with xAPI statements

* listen what the user does in child libraries
* **generate your own xAPI statements**
* **listen for xAPI statements**
  1. LibraryInstance.on('xAPI', ...)
  2. this.on('xAPI', ...)
  3. H5P.externalDispatcher.on('xAPI', ...)

## Schritt 4 - CSS für die Komponente definieren (greetingcard.css)

* use lib name as classname

## Schritt 5 - Übersetzung erstellen (language)

* H5P libraries have **built-in support for translation** of static strings in the library semantics
* done by including language files that are merge on top of the semantics objects
* folder `language\<local>.json

### Translating library semantics

1. Make a language from semantics.json
2. Rename the new file with correct language code (ISO-639-1)
3. Translate the strings in the file

## Schritt 6 - Inhalt erstellen (content)

## Schritt 7 - zip the files, rename to .zip to .h5p

### Security

two primary Security features

* HTML purifier
* file extension whitelist

---

## Sonstiges

### Einstellungen H5P Plattform

Aktiviere `enable_lrs_content_types`. Die H5P Inhalte _H5P.Questionnaire_ und _H5P.FreeTextQuestion_ benötigen LRS.

H5PDefaultStorage kann nicht genutzt werden.
