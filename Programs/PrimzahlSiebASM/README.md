Woche 4

Wir wollen die Primzahlen von 2 bis 1000 finden. Dafür benutzen wir zwei Felder.

1. Im ersten Feld setzen wir die Plätze 0 und 1 auf 0 und alle Plätze von 2 bis 1000 auf 1.
2. Wir gehen ab `p = 2` durch das Feld. Wenn bei `p` noch eine 1 steht, streichen wir seine Vielfachen ab `p * p`. Bei 3 sind das zum Beispiel 9, 12, 15 usw. Die kleineren Vielfachen sind schon gestrichen. Sobald `p * p > 1000` ist, sind wir mit dem Sieben fertig.
3. Danach gehen wir nochmal von 2 bis 1000 durch. Wenn bei einem Index noch eine 1 steht, schreiben wir die Indexzahl auf den nächsten freien Platz im Ergebnisfeld.

Das erste Feld hat 1001 Plätze mit je 1 Byte, weil da nur 0 oder 1 steht.
Das Ergebnisfeld hat 168 Plätze mit je 2 Byte. Da stehen die Primzahlen selbst drin, ab 256 reicht ein Byte ja nichtmehr