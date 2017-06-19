/*
 * VK1_c.asm
 *
 *  Created: 10.06.2017 10:44:46
 *   Author: srie
 */ 
 .nolist
.include "ATxmega128A1def.inc"
.list


; notwendige Definitionen


; -----------------------------------------------------------------------------
;					Interruptvektortabelle
; -----------------------------------------------------------------------------
.cseg
.org 0x000						; Flash Adresse 0x0000

start:
		;von 0x2000 nach 0x3000 100 BYtes im Ram kopieren

		rcall init_01

		ldi		XH,0x20		;HT des Zeigers auf Quellbereich
		ldi		XL,0x00		;LT
		;---------------------------------------------------
		ldi		YH,0x30		; HT des Zeigers auf Zielbereich
		ldi		YL,0x00		;LT
		;---------------------------------------------------
		ldi		r16,100		;Bytezähler auf 100

		;---------------------------------------------------
st01:	ld		r17,X+		;Byte aus Quellbereich lesen und X+
		st		Y+,r17		;Byte in Zielbereich schreibe, Y+
		dec		r16			;Bytezähler -1 
		brne	st01		;wenn noch nicht 0, dan weiter kopieren
		;---------------------------------------------------
st00:	rjmp	st00		;Endlosschleife

init_01:
		push	r16
		push	r17
		push	r18
		push	XH
		push	XL
		push	YH
		push	YL
		ldi		r16,100
		ldi		r17,0xFF
		ldi		r18,0x00
		ldi		XH,0x20		;HT des Zeigers auf Quellbereich
		ldi		XL,0x00		;LT
		;---------------------------------------------------
		ldi		YH,0x30		; HT des Zeigers auf Zielbereich
		ldi		YL,0x00		;LT

set_loop:		st		X+,r17
				st		Y+,r18
				dec r16
				brne set_loop

		pop		XH
		pop		XL
		pop		YH
		pop		YL
		pop		r18
		pop		r17 
		pop		r16
		ret							; return aus UP

	


; Endlosschleife Hauptprogramm ----------------------------------------------
MAINLOOP:
	
	; Hier eigenen Programmablauf eintragen

;------------------------------------------------------------------------------
; 					Unterprogramme
;------------------------------------------------------------------------------


