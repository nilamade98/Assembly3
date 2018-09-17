;
; UAS4.asm
;
; Created: 1/9/2018 12:05:28 AM
; Author : FX46
;


; Dengan timer1, bualah program led kedip pada PORTA.0 dengan delay 1 ms

.org 0x00
	jmp main

.org 0x012
	jmp TIMER1_OVF

.org 0x100
main :	ldi r16, high(ramend)
		out SPH, r16
		ldi r16, low(ramend)
		out SPL, r16

		sbi PORTA,0
		
		ldi r20, (1<<TOIE1)
		out TIMSK, r20
		sei

		ldi r20, 0x01
		out TCNT1H, r20
		ldi r20, 0x1f
		out TCNT1L, r20
		ldi r20, 0x01
		out TCCR1B, r20
		ldi r20, 0x00
		out TCCR1A, r20

		ldi r17,1

;here : rjmp here

.org 0x300
	eor r18, r17
	out PORTA, r18
	RETI

.org 0x600
TIMER1_OVF :	ldi r20, 0x01
				out TCNT1H, r20
				ldi r20, 0x1F
				out TCNT1L, r20

				jmp 0x300