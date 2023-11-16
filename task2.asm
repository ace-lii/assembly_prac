/*
 * task21.asm
 *
 *  Created: 24/09/2023 3:06:52 AM
 *  Author: li
 *  result will be stored in R26

 *  pseude code
	a' = a * 100
	sqr = a / 2 * 10

	threshold = 50

	loop: 
		if a' > sqr ^ 2:
			if a' - sqr ^ 2 > threshold:
				sqr += 1
				loop
			else:
				return sqr * a / 10
		elif a' <= sqr ^ 2:
			if a' - sqr ^ 2 > threshold:
				sqr -= 1
				loop
			else:
				return sqr * a / 10
*/
.include "m2560def.inc"
.def sqr = R20
.def a = R25
.def init_sqr = R18

.def tmp_factor = R19
.equ precision = 100

.def high_sqr_sqr = R22
.def low_sqr_sqr = R21
.def high_a = R17
.def low_a = R16

.def high_a_tmp = R31
.def low_a_tmp = R30

.def high_res = R24
.def low_res = R23
.def res = R26


main:
	;load a as input 
	ldi a, 8					;a = input
	mov init_sqr, a				;a assign to init_sqr
	ror init_sqr				;init_sqr = a/2
	ldi tmp_factor, 10			
	mul init_sqr, tmp_factor;   ;init_sqr * 10 so the precision will be 0.1
	mov sqr, R0					
	ldi tmp_factor, precision	
	mul a, R19					; a*=100
	mov high_a, R1				; high of a 		
	mov low_a, R0				; low of a

;loop compare a' with sqr*sqr
loop:
	mul sqr, sqr;				; sqr * sqr 
	mov high_sqr_sqr, R1					; high of sqr*sqr
	mov low_sqr_sqr, R0					; low of sqr * sqr

	;compare a sqr*sqr
	cp low_a, low_sqr_sqr					; low of a cp low of sqr*sqr
	cpc high_a, high_sqr_sqr				; high of a cpc high of sqr*sqr
	brsh greater				; if greater go greater
	rjmp less					; else go less

greater:
	mov low_a_tmp, low_a			;cp low of a to low_a_tmp 
	mov high_a_tmp, high_a			;cp high of a to high_a_tmp

	sub low_a_tmp, low_sqr_sqr			; low of a - low of sqr * sqr 		
	sbc high_a_tmp, high_sqr_sqr		; high of a - high of sqr * sqr

	;compare a-sqr*sqr > 100 go inc sqr and loop
	ldi R27,low(50)
	ldi R28, high(50)
	cp low_a_tmp, R27
	cpc high_a_tmp, R28	
	
	; if > threshold then inc sqr
	brsh inc_sqr_by_1

	; else sqr * a / 10
	mul sqr, a;	
	mov low_res, R0
	mov high_res, R1
	rjmp Div 


less:
	sub low_sqr_sqr, low_a				
	sbc high_sqr_sqr, high_a

	ldi R27,low(50)
	ldi R28, high(50)
	cp low_sqr_sqr, R27
	cpc high_sqr_sqr, R28

	; if > threshold then dec sqr
	brsh dec_sqr_by_1

	; else return sqr * a / 10
	mul sqr, a;	
	mov low_res, R0
	mov high_res, R1
	rjmp Div	


inc_sqr_by_1:
	inc sqr
	rjmp loop

dec_sqr_by_1:
	dec sqr
	rjmp loop

; divide opration
Div:
	ldi R27, low(10)
	ldi R28, high(10)
	cp low_res, R27				
	cpc high_res, R28

	brge DivSub					; 
	rjmp halt					;else halt
  
DivSub:
	sub low_res, R27					
	sbc high_res, R28
	inc res						;
	rjmp Div				; loop divloop 

halt:
	rjmp halt;