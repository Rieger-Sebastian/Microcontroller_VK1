/*
 * VK1E.asm
 *
 *  Created: 10.06.2017 13:28:00
 *   Author: Michael Eckhart-W
 */ 


;  -----------------------------------------------------------------------------
// notwendiger Sprung von Bootloaderadresse zum Flash - Anfang
.cseg
.org 0x10000     ; Adresse des Bootloaders
 jmp 0x000     ; Sprung zum Application Flash


; -----------------------------------------------------------------------------
;     Interruptvektortabelle
; -----------------------------------------------------------------------------
.org 0x000      ; Flash Adresse 0x0000
 rjmp RESET

; -----------------------------------------------------------------------------
;                    Beginn des Hauptprogramms
; -----------------------------------------------------------------------------
.org 0x100      ; Flash Adresse 0x0100
RESET:

; Endlosschleife Hauptprogramm ----------------------------------------------
Start: 
  ldi  r16,0b00000000   ; Initialisierung des PORTF
  sts  PORTH_DIRSET,r16  ; Datenrichtung des LED Portpins ist Ausgang
  ldi  r16, 0b11111111
  sts  PORTF_DIRSET,r16 
Loop: 
  rcall time2 
  lds  r16, PORTH_IN
  andi r16, 0b00000001
  brne sts01
  ldi  r16, 0b00000001
  sts  PORTF_OUTTGL,r16
  rjmp Loop
sts01:
  ldi  r16, 0b00000000
  sts  PORTF_DIRSET,r16
  rjmp Loop 


;------------------------------------------------------------------------------
;      Unterprogramme
;------------------------------------------------------------------------------

; Zeitverzögerung1 ------------------------------------------------------------
time1:
 ldi r30,0x00    ; temp1 = 0x00
t1: dec r30     ; temp1 = temp1 - 1
 brne t1      ; wenn Zero Flag nicht gesetzt gehe zu ti01
 ret       ; return aus UP

; Zeitverzögerung2 ------------------------------------------------------------
time2:
 ldi r31,0x9    ; temp2 = 0x00
t2: rcall time1     ; Unterprogrammaufruf "time1"
 dec r31     ; temp2 = temp2 - 1
 brne t2      ; wenn Zero Flag nicht gesetzt gehe zu ti02
 ret       ; return aus UP