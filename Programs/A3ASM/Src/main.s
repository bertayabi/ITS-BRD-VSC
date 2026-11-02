;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
                ;konstante 0x12 nach r0
				mov   r0,#0x12                      ; Anw-01
				;konstante -128 nach r1
                mov   r1,#-128                      ; Anw-02
				;konstante 0x12345678 nach r2
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
                ;adresse variableA nach r0
				ldr   r0,=VariableA                 ; Anw-04
                ;liest 2Byte ab r0 nach r1 oberen 16bit werden 0
                ldrh  r1,[r0]                       ; Anw-05
				;liest vier Byte ab R0 nach R2, also VariableA u B zsm
                ldr   r2,[r0]                       ; Anw-06
				;schreibt die 4byte aus r2 nach varC, zieladresse ist r0+ abstand der variablem
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
                ;ledt die anfangadresse der variable nach r0
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
				;liest das erste halbwort nach r1; obere 16bit werden 0
                ldrh  r1,[r0]                       ; Anw-09
				;liest das halbwort 2Byte hinter r0 nach r2; R0 bleibt gleich weil kein !
                ldrh  r2,[r0,#2]                    ; Anw-10
				;schreibt 10 in r3 (byteabstand)
                mov   r3,#10                        ; Anw-11
				;liest zwei Byte an der adresse r0+r3 nach r4
                ldrh  r4,[r0,r3]                    ; Anw-12

                ;liest zwei Byte an R0 + 2 nach R5 und schreibt die neue Adresse nach R0
                ldrh  r5,[r0,#2]!                   ; Anw-13
				;Liest zwei Byte an R0 + 2 nach R6 und schreibt die neue Adresse nach R0
                ldrh  r6,[r0,#2]!                   ; Anw-14
				;schreint die unteren 2byte von r6 an r0+2 die neue adresse ebenfalls
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ;anfangsadresse nach r0
                ldr  r0,=MeinWortFeld               ; Anw-16
				;liest erstes wort (4byte) nach r1
                ldr  r1,[r0]                        ; Anw-17
				;liest zweites wort 4 byte verschoben nach r2
                ldr  r2,[r0,#4]                     ; Anw-18
				;Addiert R1 und R2 nach R3
                adds r3,r1,r2                       ; Anw-19

                ;liest das dritte wort 8byte vercshoben nach r4
                ldr  r4,[r0,#8]                     ; Anw-20
				;liest das vierte wort 12 byte verschoben nach r5
                ldr  r5,[r0,#12]                    ; Anw-21
				;rechnet r4-r5 nach r6 
                subs r6,r4,r5                       ; Anw-22

                ;liest das 5te wort 16byte verschoben nach r7
                ldr  r7,[r0,#16]                    ; Anw-23
				;liest das 6te wort 20byte verschoben nach r8
                ldr  r8,[r0,#20]                    ; Anw-24
				;rehcnet r7-r8 nach r9
                subs r9,r7,r8                       ; Anw-25

                ;endlosschleife
forever         b   forever                         ; Anw-26
                ENDP
                END