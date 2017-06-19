/*
 * VK01_e.asm
 *
 *  Created: 10.06.2017 13:30:51
 *   Author: srie
 */ 

 .nolist
.include "ATxmega128A1def.inc"
.list

// notwendiger Sprung von Bootloaderadresse zum Flash - Anfang
.cseg
.org 0x10000					; Adresse des Bootloaders
	jmp	0x000					; Sprung zum Application Flash


; notwendige Definitionen
.def temp1 = r20
.def temp2 = r21
.def temp3 = r22

; -----------------------------------------------------------------------------
;					Interruptvektortabelle
; -----------------------------------------------------------------------------
.org 0x100		


; Endlosschleife Hauptprogramm ----------------------------------------------
.org 0x000						; Flash Adresse 0x0000

MAINLOOP:
	ldi		r16,0b00000000		;Maske für PORT lesen/schreiben
	sts		PORTH_DIRSET,r16	;PORTA setzen lesen

	ldi		r16, 0b11111111		;Maske für PORT F	
	sts		PORTF_DIRSET,r16	; PORTF als ausgang definiert
listen:
	lds		r17,PORTH_IN	;PortA auslesen
	ldi		r18,0b00000001	;vergleichsregister
	AND		r17,r18
	brne	listen
	rjmp	sound

sound:
	ldi		r19,0b00000001		; lade temp1 mit Bitmaske
	sts		PORTF_OUTTGL,r19		; toggle Pin an PORTF
	rcall	time2					; Zeitverzögerung

	rjmp listen				; Hauptschleife
;------------------------------------------------------------------------------
; 					Unterprogramme
; Zeitverzögerung1 ------------------------------------------------------------
time1:
	ldi	temp1,0x00				; temp1 = 0x00
t1:	dec	temp1					; temp1 = temp1 - 1
	brne t1						; wenn Zero Flag nicht gesetzt gehe zu ti01
	ret							; return aus UP
#; Zeitverzögerung2 ------------------------------------------------------------
time2:
	ldi	temp2,0x09				; temp2 = 0x00
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
	ret							; return aus UP						; return aus UP
;------------------------------------------------------------------------------





