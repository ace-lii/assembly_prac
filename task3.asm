;
; lab2.asm
;
; Created: 8/10/2023 1:46:37 AM
; Author : li
;


; Replace with your application code
.include "m2560def.inc"
.equ loop_count = 65535


.def iH = r25
.def iL = r24
.def countH = r18
.def countL = r17

.macro delay
		ldi countL, low(loop_count) ; 1 cycle
		ldi countH, high(loop_count)
		clr iH ; 1
		clr iL

	loop:
		cp iL, countL ; 1
		cpc iH, countH
		brsh done ; 1, 2 (if branch)
		adiw iH:iL, 1 ; 2
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1


		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		nop ; 1
		rjmp loop ; 2
	done:
.endmacro


;input 
cbi ddrd,0 ;pb0
cbi ddrd,1 ;pb1

;output
ser r16
out ddrc,r16 ;


;3 patterns
ldi r20, 0b10000001
mov r0, r20

ldi r21, 0b00011000
mov r1, r21

ldi r22, 0b11111111
mov r2, r22

ldi r19, 0b00000000

.def n = r23

ldi n,0
ldi zl, $0



loop:
	sbis pind, 0 ; if pb0 pressed run pattern1
	rjmp pattern1

	sbis pind, 1 ; if pb1 pressed run pattern0
	rjmp pattern0

	rjmp loop

pattern0:
	out portc, r19
	delay
	rjmp loop



pattern1:
	sbic pind, 0   ;if pb0 pressed skip next instruction
	rjmp pattern1 

	ld R16, Z+		; set r16 with Z address R*, z++
	out portc, r16 ; diaplay r16
	delay

	inc n           ;n+1
	cpi n, 4		;reset pattern if n >= 4
	brsh reset_pattern

	;delay
	rjmp pattern2   ; jump to loop

pattern2:
	sbic pind, 0   ;if pb0 pressed skip next instruction
	rjmp pattern2

	ld R16, Z+		; set r16 with Z address R*, z++
	out portc, r16 ; diaplay r16
	delay

	inc n           ;n+1
	cpi n, 4		;reset pattern if n >= 4
	brsh reset_pattern

	;delay
	rjmp pattern3   ; jump to loop

reset_pattern:

	ldi zl, $0
	ldi n, 0
	rjmp loop

pattern3:
	sbic pind, 0   ;if pb0 pressed skip next instruction
	rjmp pattern3 

	ld R16, Z+		; set r16 with Z address R*, z++
	out portc, r16 ; diaplay r16
	delay
	delay


	ld R16, Z+		; set r16 with Z address R*, z++
	out portc, r16 ; diaplay r16
	delay
	delay


	ld R16, Z+		; set r16 with Z address R*, z++
	out portc, r16 ; diaplay r16
	delay
	delay


	;delay
	sbic pind, 0
	rjmp loop   ; jump to loop
	rjmp pattern3

	inc n           ;n+1
	cpi n, 4		;reset pattern if n >= 4
	brsh reset_pattern1

	

reset_pattern1:

	ldi zl, $0
	ldi n, 0
	rjmp loop



	

end:
	rjmp end
