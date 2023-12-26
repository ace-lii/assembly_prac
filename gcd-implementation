/*
 * task3.asm
 *
 *  Created: 25/09/2023 12:38:20 PM
 *   Author: li
 */ 
.include "m2560def.inc"

.def big =  R18
.def small = R19
.def tmp_ = R20
.def res = R21


ldi big, 214
ldi small, 102
rjmp loop

swap_small_to_big:
	mov tmp_, small
	mov small,big 
	mov big, tmp_
	rjmp loop

loop:
	cp small, big
	brsh swap_small_to_big

	cpi small, 1
	brsh Div
	mov res, big
	rjmp end

Div:
    cp big, small
	brsh DivSub
	rjmp loop
DivSub:
	sub big, small				
	rjmp Div


end: nop
