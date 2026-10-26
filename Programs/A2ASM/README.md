

anw1 Die adresse von VariableA wird geladen und in r0 gespeichert

anw2 danach wird ein byte vom wert der sich in der in r0 gespeicherten 
adresse befindet (0xbeef -> 0xef) gelesen und in r2 gespeichert

anw3 danach wird das nächste byte (0xbe) gelesen und in r3 gespeichert

anw4 mit lsl wird der wert der sich in r2 befindet um 8bit/1byte nach links verschoben (0xef00) und speichert das dort wieder ab

anw5 danach wird anhand des operators orr die bits von r2 u r3 verknüpft und in r2 gespeichert (-> 0xefbe)
anw6 anschließend wird r2 mit strh in die adresse die sich in/bei r0 befindet geschrieben -> jetzt wird was am speicher geändert soweit ich das verstanden habe

jetzt wenn man auf gdb geht &VariableA eingibt etc wird das gewünschte beef angezeigt