/*
 * task3.asm
 *
 *  Created: 25/09/2023 12:38:20 PM
 *  Author: li
 *	result will be stored in R18
 *  pseudo code below
	
	Y = &R0						;assign address of R0 to Y
	Z = &R1						;assign addres of R1 to Z
	R16 = from 0 to n 
	R18 = Y						;assign Y's value to R18 
	while R16 <= 5 :
		R19 = Z					;assign Z's value to R19
		Z += 1					;Z pointer next address
		R18 = gcd (R18, R19)	;gcd (R18, R19)
		inc R16

	
	gcd(big, small):
		while (small != 0 ):
			remainder = big % small
			big = small
			small = remainder
		end while 
		return big 
 */ 
.include "m2560def.inc"

.def big =  R18
.def small = R19
.def tmp_ = R20
.def res = R21
.def n_max = R17
.def n = R16



.macro gcd
	 mov big, @0
	 mov small, @1
	 rjmp loop

; swap if small > big
swap_small_to_big:
	mov tmp_, small
	mov small,big 
	mov big, tmp_
	rjmp loop

; loop if small != 0
loop:
	cp small, big
	brsh swap_small_to_big

	cpi small, 1
	brsh Div
	mov res, big
	rjmp end

;divide
Div:
    cp big, small
	brsh DivSub
	rjmp loop
DivSub:
	sub big, small				
	rjmp Div
end: nop
.endmacro


ldi n, 0
ldi n_max, 5
ldi YL, $01
ldi ZL, $02



ld R18, Y
LOOP:
	ld R19, Z+
	gcd R18, R19
    INC n
    CP n_max, n
    brsh LOOP  
	rjmp halt


halt:
	rjmp halt;