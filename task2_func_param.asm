/*
 * task2_func_param.asm
 *
 *  Created: 11/10/2023 5:09:53 AM
 *   Author: li
 */ 
.include "m2560def.inc"
.dseg
	.org 0x200
	count: .byte 1

.cseg
my_string: .db "COMP 9032."  ; input string

;main
lds zl, my_string
rcall len
rjmp end

end:
	rjmp end


len: 
	;prologue
	push YL				;save r29:r28 in the stack will be used for frame stack
	push YH   

	push r16			;save registers used in the func body
	push r17

	
	in YL, SPL			;init the stack frame pointer value, copy io register (SP) to general purpose register (Y)
	in YH, SPH 

	out SPH, YH
	out SPL, YL

	std Y+1, zl
	; end prologue

	;func body
	clr r17				;init r17 = 0


	loop:
		lpm r16, Z+
		cpi r16, 0x2e			; if .(ascii 0x2e) return
		breq done				
		cpi r16, 0x20			;if space(ascii 0x20) word cnt ++
		breq space	
		rjmp loop	
	space:
		inc r17
		rjmp loop				
	done:
		inc r17
		mov r18, r17
		;save to data mem
		ldi xh, high(count)
		ldi	xl, low(count)
		st x, r18
	; end func body

	;epilogue
		out SPH, YH
		out SPL, YL
		pop zh
		pop zl
		pop r17
		pop r16
		pop YH
		pop YL
		ret
	;end epilogue