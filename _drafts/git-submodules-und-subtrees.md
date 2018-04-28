---
title: Git Submodules und Subtrees
tags: [git, multiple-projects]
---

## Submodules und Subtrees

Mit Submodules und Subtrees sind in Git zwei Möglichkeiten enthalten, ein Repository in einem anderem Repository einzubinden.

    Git Submodule
    =============
                             +
    +--------------------+   |   +-------------+
    |        Root        +------->    Root     |
    |     Repository     |   |   | Repository  |
    |         +          |   |   +------+----+ +
    |         |          |   |          |
    |    (Commit-Id)     |   |     (Commit-Id)
    |         |          |   |          |
    |         |          |   |          |
    | +-------v--------+ |   |   +------v------+
    | |  eingebundenes +--------->eingebundenes|
    | |   Repository   | |   |   | Repository  |
    | +----------------+ |   |   +-------------+
    +--------------------+   |
                             |
            lokal            |       entfernt
                             +

Bei der Verwendung von _Submodules_ wird im Root-Repository auf ein Commit des eingebundenen Repositorys verwiesen. Für das Root-Repository ist der Inhalt des eingebundenen Repositorys unbekannt, ähnlich wie eine Blackbox. Es ist optional, ob der Inhalt des eingebundenen Repositorys geladen werden soll. Andernfalls bleibt der entsprechende Ordner leer. Sowohl das Root-Repository als auch das eingebundene Repository bleiben lokal zwei eigenständige Repositorys. Das heißt, Änderungen im Root-Repository und Änderungen im eingebundenen Repository sind separat zu committen.

    Git Subtree
    ===========
                             +
    +--------------------+   |   +-------------+
    |        Root        +------->    Root     |
    |     Repository     |   |   | Repository  |
    |                    |   |   |             |
    |                    |   |   |eingebundenes|
    |                    |   |   | Repository  |
    |                    |   |   +-------------+
    |                    |   |
    |                    |   |   +-------------+
    |    eingebundenes +--------->eingebundenes|
    |     Repository     |   |   | Repository  |
    |                    |   |   +-------------+
    +--------------------+   |
                             |
            lokal            |       entfernt
                             +

Bei der Anwendung des _Subtree_-Ansatzes wird ein Repository in ein anderes Repository kopiert. Lokal handelte es sich um ein _einzelnes_ Repository. Der Inhalt des eingebundenen Repository ist für das Root-Repository ersichtlich und ähnelt somit einer Whitebox. Änderungen am Root-Repository und am eingebundenen Repository können in einem Commit zusammengefasst werden. Die Aufteilung der Änderungen auf die entfernten Repositorys erfolgt automatisch.

## Arbeiten mit Submodule

Mit `git submodule add <url>` wird ein neues Submodule zu einem Repository hinzugefügt. Git erstellt automatisch die Datei `.gitmodules`. In der Datei wird für jedes Submodule, der Ordner und die Adresse des entfernten Repositorys festgehalten. Außerdem wird im Root-Repository die Commit-ID vorgehalten, mit der das Submodule geladen werden soll.

Der Befehl `git clone --recurse-submodules <url>` ermöglicht es, ein Git Repository einschließlich der Inhalten der Submodules zu clonen. Ohne das Flag `--recurse-submodules` werden für die Submodules nur leere Ordner in dem Root-Repository erstellt.

Wurden im entfernten Repository des Submodules Änderungen vorgenommen, sind zwei Aktionen auszuführen, um die Änderungen dauerhaft im Root-Repository zu übernehmen. Zunächst ist in das Verzeichnis des Submodules zu wechseln und anschließend mit `git pull` die Änderungen vom Repository zu laden. Damit das Submodule einschließlich dieser Änderungen auch dauerhaft vom Root-Repository geladen werden, ist als Nächstes wieder in das überliegende Verzeichnis zu wechseln und die geänderte Commit-ID des Submodules zu committen.

Sollen Änderungen aus dem Submodule an das entfernte Repository übertragen werden, ist ähnlich wie beim vorhergehenden Schritt vorzugehen. Zunächst wird in das Verzeichnis des Submodules gewechselt und die Änderungen an das entfernte Repository gepusht. Im Anschluss wird in das Root Projekt gewechselt und die geänderte Commit-ID des Submodules gepusht.

## Arbeiten mit Subtree

Bevor mit Subtrees gearbeitet wird, kann mit dem Befehl `git remote add sub_remote <url>` dem entfernten Subtree Repository einem Namen zugewiesen werden. Bei der Eingabe der nachfolgenden Befehle reicht es aus, nur diesen Namen anzugeben.

Der Befehl `git subtree add --prefix=<Ordnername> sub_remote master --squash` fügt ein Subtree zu einem Repository hinzu. Das eingebundene Repository ist anschließend Bestandteil des Root-Repositorys. Das heißt, Änderung im eingebundenen Repository werden wie alle anderen Änderungen committet und mit dem Befehl `git push` an das entfernte Root-Repository übermittelt.

Sollen hingegen Änderungen des eingebundenen Repositorys an dessen entfernten Repository übertragen werden, ist dies mit dem Befehl `git subtree push --prefix=<Ordnername> sub_remote master` möglich. Es werden automatisch alle Commits durchlaufen und nur die Änderungen, die das eingebundene Repository betreffen, an das entfernte Repository übertragen. Genauso, aber in umgekehrter Richtung, können mit dem Befehl `git subtree pull --prefix=<Ordnername> sub_remote master --squash`, Commits von dem entfernten eingebunden Repository geholt werden.

* * *

Referenzen

-   <https://git-scm.com/book/en/v2/Git-Tools-Submodules>
-   <https://www.atlassian.com/blog/git/git-submodules-workflows-tips>
-   <https://medium.com/@porteneuve/mastering-git-submodules-34c65e940407>
-   <https://medium.com/@porteneuve/mastering-git-subtrees-943d29a798ec>
