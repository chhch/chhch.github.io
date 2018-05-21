---
title: Java Classloader
tags: [java]
---

Klassen können in Java sowohl statischen als auch dynamischen geladen werden. Für das statische Laden von Klassen muss der Name, der zu ladenden Klasse, während des Kompilierens bekannt sein. In dem Fall kann eine Instanz mit dem `new`-Operator erzeugt werden. Anders ist es beim dynamischen Laden. Der Klassenname wird dem Classloader in dem Fall erst zur Laufzeit übergeben. Möglich ist das in Java beispielsweise über den Aufruf der Methode `Class.forName(String)`.

Die Classloader sind hierarchisch organisiert. Bevor ein Classloader eine Klasse lädt, prüft er, ob die Klasse bereits vom Parent geladen wurde. Das Gleiche gilt für dessen Parent. Solange bis ein Parent gefunden wurde, der die Klasse bereits geladen hat oder der oberste Classloader, standardmäßig der _Bootstrap-Classloader_, erreicht wurde. Existiert kein weiterer Parent, versucht der Classloader, die Klasse selbst zu laden. Gelingt dies nicht, versucht es dessen Kind und so weiter.

    Classloader Hierarchie
    ======================

    Bootstrap-Classloader+--->jre/lib-Verzeichnis
             +                 (System abhängig)
             |
             v
    Extension-Classloader+--->lib/ext-Verzeichnis
             +
             |
             v
      System-Classloader+---->Klassenpfad
             +
             |
             v
      Custom-Classloader (vom Entwickler)

Der Standard Classloader erlaubt es nicht, eine geladene Klasse erneut zu laden. Soll eine Klasse zum Beispiel mit Änderungen zur Laufzeit erneut eingelesen werden, ist entweder ein anderer Classloader zu verwenden, oder alle Referenzen auf die Klasse sowie dessen Classloader selbst sind zu entfernen, um die Klasse für den Garbage-Collector freizugeben.

Instanzen von Klassen, die den selben Namen haben und sich im selben Package befinden, sind nicht vom selben Typ, wenn sie von unterschiedlichen Classloader geladen wurden.

Mit den URLClasLoader können Klassen einer URL geladen werden. Dabei kann es sich zum Beispiel, um den Pfad eines `.jar`-Archivs handeln.

* * *

Referenzen:

-   <https://docs.oracle.com/javase/8/docs/api/java/lang/ClassLoader.html>
-   <http://openbook.rheinwerk-verlag.de/javainsel9/javainsel_11_002.htm>
-   <https://www.philipphauer.de/study/se/classloader.php>
-   <https://www.youtube.com/watch?v=S7whKuAvRBU>
