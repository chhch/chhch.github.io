---
title: Gradle Composite Builds
tags: [gradle, multiple-projects]
---

## Multiple Projects Builds

Umfangreiche Software Projekte bestehen meist aus verschiedenen Modulen. Zwischen den Modulen bestehen oft Abhängigkeiten, sodass nicht immer isoliert nur an einem Modul entwickelt werden kann. Allerdings kann es, je nach Projekt, auch sehr aufwendig sein, immer alle Module zu laden. Verschiedenen Varianten ein Projekt zu strukturieren werden nachfolgend vorgestellt.

## Mono-Repo

In einem _Mono-Repository_ werden alle Module in einem Projekt geladen. Die einzelnen Module können direkt aufeinander zugreifen. Der Umweg über ein Repository ist für den Zugriff daher nicht nötig.

    Mono-Repo
    =========

    +----------------+    +----------------+
    | Projekt        |    | Repository     |
    |                |    |                |
    |  +----------+  |    |  +----------+  |
    |  | Module 1 |  |    |  | Module 1 |  |
    |  +----+-----+  |    |  +----------+  |
    |       |        |    |                |
    |  +----v-----+  |    |  +----------+  |
    |  | Module 2 |  |    |  | Module 2 |  |
    |  +----+-----+  |    |  +----------+  |
    +----------------+    +----------------+

Diese Variante der Strukturierung hat den Vorteil, dass nur ein Repository benötigt wird. Es muss nur ein Projekt geöffnet werden. Funktionen der Entwicklungsumgebung für beispielsweise die Refaktorisierung von Code können über die Modulgrenzen hinweg genutzt werden. Die Auswirkungen von Änderungen auf den Code sind sofort ersichtlich, es gibt keine Probleme mit verschiedenen Versionen der einzelnen Module.

Die Ladezeit der Entwicklungsumgebung kann stark zunehmen, wenn ein sehr umfangreiches Projekt bearbeitet wird. Der Build-Prozess schließt alle Module ein, womöglich auch für den aktuellen Entwicklungsschritt unnötige. Es besteht kein Zwang, bei der Entwicklung auf Modularität Rücksicht zu nehmen.

## Multi-Repo

Bei der _Multi-Repository_ Variante wird für einzelne Module ein eigenes Projekt erstellt. Auf andere Module wird über das Repository zugegriffen.

    Multi-Repo
    ==========

    +-----------------+    +----------------+
    | Projekt 1       |    | Repository     |
    |  +----------+   |    |  +----------+  |
    |  | Module 1 +---------- > Module 2 |  |
    |  +----------+   |    |  +----------+  |
    +-----------------+    |                |
                           |                |
    +-----------------+    |                |
    | Projekt 2       |    |                |
    |  +----------+   |    |  +----------+  |
    |  | Module 2 |   |    |  | Module 1 |  |
    |  +----------+   |    |  +----------+  |
    +-----------------+    +----------------+

Der Vorteil dieser Variante liegt in der stärkeren Modularität. Dies vereinfacht die Arbeit mit verschiedene Release-Zyklen, die Auswahl der Werkzeuge und die Aufteilung auf Teams. Die Codebasis einzelner Projekte ist kleiner und die Arbeit in der Entwicklungsumgebung daher performanter.

Auf der anderen Seite ist das Beheben eines Fehlers in einem anderen Modul aufwendiger, da dafür zunächst das Modul geladen werden muss. Außerdem müssen Änderungen die mehrere Module betreffen für jedes Modul Manuel durchgeführt werden. Da es sich um eine binäre Abhängigkeit zwischen den Modulen handelt, ist es nicht möglich auf Funktionen der Entwicklungsumgebung zu nutzen, um diesen Prozess zu automatisieren.

## Composite Builds

Die letzte Variante kombiniert die Vorteile von Mono-Repositorys und Multi-Repositorys. _Composite-Builds_ ermöglichen es auf ein anderes Modul sowohl über das Repository zuzugreifen als auch das Modul innerhalb des Projekts einzubinden. Je nach Aufgabe kann flexibel zwischen beiden Varianten gewechselt werden.

    Composite Builds
    ================

    +-----------------+    +----------------+
    | Projekt 1       |    | Repository     |
    |  +----------+   |    |  +----------+  |
    |  | Module 1 +---------- > Module 2 |  |
    |  +----------+   |    |  +----------+  |
    +--------+--------+    |                |
             |             |                |
    +--------v--------+    |                |
    | Projekt 2       |    |                |
    |  +----------+   |    |  +----------+  |
    |  | Module 2 |   |    |  | Module 1 |  |
    |  +----------+   |    |  +----------+  |
    +--------+--------+    +----------------+

Für die Realisierung in Gradle, ist für jedes Projekt eine Datei mit dem Namen `settings.gradle` anzulegen. Für das _Projekt 1_ hat die Datei folgenden Inhalt.

```groovy
rootProject = 'project-1'

includeBuild '../project-2'
```

Zusätzlich enthält die Datei `buidl.gradle` die Abhängigkeit zu den Binäredaten von Projekt 2. Dies kann wie folgt aussehen.

```groovy
// ...
dependencies {
  // ...
  compile 'org.company:project-2:1.0'
  // ...
}
// ...
```

Kann Gradle während des Build-Prozesses den Ordner `../project-2` finden, wird der Inhalt des Ordners hinzugefügt. Andernfalls greift Gradle auf das Repository, um die Abhängigkeit aufzulösen.

* * *

Referenzen

-   <https://docs.gradle.org/current/userguide/composite_builds.html>
-   <https://blog.jetbrains.com/idea/2017/03/webinar-recording-composite-builds-with-gradle/>
-   <https://discuss.gradle.org/t/future-of-composite-builds/26311>
