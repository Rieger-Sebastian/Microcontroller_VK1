;------------------------------------------------------------------------------
; Project : blinkende LED
; Date    : 02.2015
; Author  : HPO, HAG
; Company : ACMC Hochschule Mittweida D09648     
; Hardware: hd2 mit XMEGA128A1
;------------------------------------------------------------------------------

.nolist
.include "ATxmega128A1def.inc"
.list


;Lautsprecher PH0

; Definitionen
.def temp1 = r16
.def temp2 = r17
.def temp3 = r18

; -----------------------------------------------------------------------------
// notwendiger Sprung von Bootloaderadresse zum Flash - Anfang
.cseg
.org 0x10000					; Adresse des Bootloaders
	jmp	0x000					; Sprung zum Application Flash

; -----------------------------------------------------------------------------
;					Interruptvektortabelle
; -----------------------------------------------------------------------------
.org 0x000						; Flash Adresse 0x0000
	rjmp RESET

; -----------------------------------------------------------------------------
;                    Beginn des Hauptprogramms
; -----------------------------------------------------------------------------
.org 0x100						; Flash Adresse 0x0100
RESET:
	rcall CLOCK_INIT_16MHZ		; Initialisierung der Taktquelle

	ldi	temp1,0b00000010		; Initialisierung des PORTF
	ldi temp2,0b11011111
	
	sts	PORTF_DIRSET,temp1		; Datenrichtung des LED Portpins ist Ausgang

; Endlosschleife Hauptprogramm ----------------------------------------------
MAINLOOP:
	lds		r19,PORTH_IN

	ldi	temp1,0b00000010		; lade temp1 mit Bitmaske
	sts	PORTF_OUTTGL,temp1		; toggle Pin an PORTF

	rcall	time3				; Zeitverzögerung

	rjmp MAINLOOP				; Hauptschleife

;------------------------------------------------------------------------------
; 					Unterprogramme
;------------------------------------------------------------------------------

; Zeitverzögerung1 ------------------------------------------------------------
time1:
	ldi	temp1,0x00				; temp1 = 0x00
t1:	dec	temp1					; temp1 = temp1 - 1
	brne t1						; wenn Zero Flag nicht gesetzt gehe zu ti01
	ret							; return aus UP

; Zeitverzögerung2 ------------------------------------------------------------
time2:
	ldi	temp2,0x00				; temp2 = 0x00
t2:	rcall time1					; Unterprogrammaufruf "time1"
	dec	temp2					; temp2 = temp2 - 1
	brne t2						; wenn Zero Flag nicht gesetzt gehe zu ti02
	ret							; return aus UP
	
; Zeitverzögerung3 ------------------------------------------------------------
time3:
	ldi	temp3,0x05				; temp3 = 0x32
t3:	rcall time2					; Unterprogrammaufruf "time1"
	dec	temp3					; temp3 = temp3 - 1
	brne t3						; wenn Zero Flag nicht gesetzt gehe zu ti03
	ret							; return aus UP

;------------------------------------------------------------------------------
; notwendige Includes ---------------------------------------------------------
.nolist
.include "Systemtakt.inc"
.list
