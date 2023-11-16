/*
 * task2.asm
 *
 *  Created: 8/10/2023 10:36:47 AM
 *   Author: li
 */ 
 .dseg
 .org 0x200
 count: .byte 1

 ;read sentence from program mem
.cseg

my_string: .db "COMP 9032."  ; input string
ldi r17, 0

loop:
	lpm r16, Z+				; load each word within a sentence from the program mem point to by Z 
	cpi r16, 0x2e			; if .(ascii 0x2e) the sentence end
	breq done				
	cpi r16, 0x20			;if space(ascii 0x20) word cnt ++
	breq space	
	rjmp loop					
done:
	inc r17
	rjmp store_to_data_mem

space:
	inc r17
	rjmp loop

store_to_data_mem:
	ldi xh, high(count)
	ldi	xl, low(count)
	st x, r17
	rjmp end

end:
	rjmp end
