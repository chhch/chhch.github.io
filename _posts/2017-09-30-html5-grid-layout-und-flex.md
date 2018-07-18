---
title: HTML5-Elemente, Grid-Layout und Flexbox
tags: [html, css]
---

## HTML5-Elemente

HTML5 bietet einige semantische Elemente, mit denen bestimmte Bereiche einer Seite ausgezeichnet werden können. Dazu zählen unter anderem: `header`, `main`, `footer`, `nav`, `article` und `section`.

Das Element `main` sollte möglichst nur einmal auf der Seite verwendet werden. Die anderen Elemente können mehrfach auf einer Seite vorkommen. Es ist erlaubt die Elemente `article` und `section` beliebig ineinander zu verschachteln, wenn es Sinn macht.

Das Element `article` soll für Inhalte verwendet werden, die für sich _allein_ stehen können, dies kann zum Beispiel ein Beitrag in einem Blog sein. Wohingegen das Element `section` einen Abschnitt eines Dokumentes beschreibt. Häufig steht innerhalb der beiden Elemente mindestens eine Überschrift. Wirkt sich ein Bereich nicht auf die Gliederung der Seite aus, ist die Verwendung eines `div`-Elements oft die bessere Wahl.

## Grid-Layout

Das CSS _Grid-Layout_ erlaubt es, das Layout einer Seite mit einem zweidimensionalen Gitter zu beschreiben. Die Größe der einzelnen Zellen kann entweder fix oder flexibel festgelegt werden.

```css
body {
  display: grid;
  grid-template-columns: 1fr 800px 1fr;
  grid-template-rows: 30px 1fr 30px;
  grid-row-gap: 30px;
  grid-template-areas: "hd hd hd"
                       ".. mn .."
                       "ft ft ft";
  min-height: 100vh;
}
```

Der oben stehende CSS-Code erzeugt das folgende Layout:

          1fr  800p 1fr
         +----+----+----+
    30px | hd | hd | hd |
         +--------------+
     1fr |    | mn |    |
         +--------------+
    30px | ft | ft | ft |
         +----+----+----+

Die Einheit `fr` steht für Fraction. Der freie Platz wird entsprechend zum Verhältnis der gesamten Fraction aufgeteilt. In dem gezeigten Fall bekommen sowohl die linke als auch die rechte Spalte die Hälfte der noch zur Verfügung stehenden Fläche, da die gesamte Fraction den Wert 2 hat. Bei der Definition der Reihen wurde nur eine Fraction angegeben. Also bekommt die mittlere Reihe die gesamte übrige freie Fläche.

Außerdem wurde das Grid mit in die verschiedene Bereiche `hd`, `mn` und `ft` eingeteilt. In den oberen drei Spalten soll der Kopfzeile (Header) der Seite dargestellt werden. Der Hauptbereich (Main) befindet sich in der Mitte. Die Spalten links und rechts von der Mitte bleiben leer. Dies wird durch mindestens ein Punkt kenntlich gemacht. Am unteren Rand befindet sich schließlich die Fußzeile (Footer).

HTML-Elemente können einen der Bereiche zugeordnet werden. Wobei der Name für die Bereiche frei wählbar ist, jedoch müssen die in `grid-template-areas` definierten Namen mit denen in `grid-area` angegebenen übereinstimmen.

```css
body > header {
  grid-area: hd;
}

body > main {
  grid-area: mn;
}

body > footer {
  grid-area: ft;
}
```

Zusätzlich ist es möglich, die Elemente des Grids auszurichten. Dies kann auf verschiedenen Weisen erfolgen. Zunächst können die Elemente vertikal mit `align-...` oder horizontal mit `justify-...` ausgerichtet werden.

**Ein bestimmtes Element** kann **innerhalb seines Bereichs** mit `align-self` bzw. `justify-self` ausgerichtet werden. Sind **alle Elemente** eines Grids auf die gleiche Weise **innerhalb ihres Bereichs** auszurichten, kann dies durch die Angabe von `align-items` bzw. `justify-items` erfolgen.

Angewendet wird der Ausdruck `...-self` in dem umschließenden Element. Und der Ausdruck `-items` steht entsprechend im Grid-Element, wo auch `display: grid;` angegeben wurde.

Außerdem ist es möglich, Element **innerhalb des Grid-Elements** auszurichten. Dies kann mit dem Ausdruck `align-content` bzw. `justify-content` realisiert werden.

                          Ausrichtung
                               +
                               |
                      +--------+--------+
                      |                 |
                      v                 v
                    align-           justify-
                  (vertikal)       (horizontal)
                      +                 +
                      |                 |
            +---------+--------+--------+--------+
            |                  |                 |
            v                  v                 v
           self              items             content
     (einzelnes Element  (alle Elemente    (alle Elemente
      innerhalb seines   innerhalb ihres    innerhalb des
         Bereichs)          Bereichs)       umschließenden
                                             Containers)

Je nach Eigenschaft können unter anderen die Werte `auto`, `flex-start`, `flex-end`, `center`, `baseline`, `space-between`, `stretch` oder `space-around` zugewiesen werden.

## Flexbox

_Flexbox_ funktioniert ähnlich wie das Grid-Layout. Allerdings können Elemente in einer Flexbox **entweder** horizontal **oder** vertikal angeordnet werden. Ist der Inhalt nicht in einer Zeile darstellbar, wird der Inhalt ggf. **automatisch** in die nächste Zeile umgebrochen. Für ein zweidimensionales Layout ist daher ein Grid-Layout oft besser geeignet.

Für die Verwendung von Flexbox muss in dem umschließenden Container, die Eigenschaft `display: flex` gesetzt werden. Die enthaltenden Elemente können die Eigenschaft `flex: <grow> <shrink> <basis>` zugewiesen bekommen. Mit `flex-grow` und `flex-shrink` kann festgelegt werden, wie das Element relativ zu den anderen Elementen des Containers wächst bzw. sich verkleinert. Mit `flex-basis` wird die Breite des Elements angegeben werden, von dem aus dann evtl. wächst und sich verkleinert.

Mit `align-self` kann das Element innerhalb seines Bereichs ausgerichtet werden. Je nachdem, ob in dem Container `flex-direction: row` oder `flex-direction: column` gesetzt ist, werden die Elemente horizontal oder vertikal angeordnet. Daher fällt `justify-self` weg.

Die Ausdrücke `align-content` und `justify-content` beziehen sich, wie beim Grid Layout, auf die Position der Elemente innerhalb des Containers.
