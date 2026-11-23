; Ziel: Primzahlen von 2 bis einschließlich 1000 bestimmen
;
; SIEB: Das Feld vorbereiten
; Der Index ist die untersuchte Zahl, eine 1 markiert einen Kandidaten
;
; 0 und 1 sind keine primzahlen, selbsterklärend
; feld[0] = 0; 
; feld[1] = 0;
;
; for (i = 2; i <= 1000; i++) {
;     feld[i] = 1;
; }
;
; nur noch markierte Zahlen p bearbeiten
; bei p*p beginnen, weil kleinere echte Vielfache schon gestrichen sind
;
; for (p = 2; p * p <= 1000; p++) {
;     if (feld[p] == 1) {
;         for (i = p; p * i <= 1000; i++) {
;             m = p * i;
;             feld[m] = 0;
;         }
;     }
; }
;
; ABSPEICHERN: Jede Zahl mit einrr 1 ins Ergebnisfeld übernehmen
; anzahl ist der nächste freie index im ergebnisfeld
;
; anzahl = 0;
; for (i = 2; i <= 1000; i++) {
;     if (feld[i] == 1) {
;         ergebnis[anzahl] = i;
;         anzahl = anzahl + 1;
;     }
; }