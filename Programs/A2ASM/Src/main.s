;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Martin Becke    
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2    
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC   DCW 0x0 ;2 byte platz reservieren

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Anw01 
    ldrb    R2,[R0]         ; Anw02 
    ldrb    R3,[R0,#1]      ; Anw03
    lsl     R2, #8          ; Anw04 
    orr     R2, R3          ; Anw05 
    strh    R2,[R0]         ; Anw06 
    
;* const in var
    mov     R5,#ConstByteA  ; Anw07
    strh    R5,[R0]         ; Anw08
    ldr R0,=VariableC
    lsr     R2, R5, #8      ; wert von r5 um 8 bit nach rechts und in r2 speichern
    lsl     R3, R5, #8      ; ergibt 0xaffe00 in r3
    orr     R2, R3          ; macht aus dem 0xaf 0xaffeaf in r2
    strh    R2, [R0]        ; wegen strh sind nur 2byte relevant, also 0xfeaf

;* Change value from x1234 to x3412
    ldr     R1,=VariableB   ; Anw09
    ldrh    R6,[R1]         ; Anw0A
    mov     R7, #0x2200 - 0x22     ; Zahl so konfigurieren dass man direkt nach dem add zum gesuchten 3412 kommt
    add     R6, R6, R7      ; Anw0C
    strh    R6,[R1]         ; Anw0D
    b .                     ; Anw0E
    
    ALIGN
    END