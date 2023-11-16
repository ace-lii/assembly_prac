/*
 * task3_sub.asm
 *
 *  Created: 26/09/2023 2:25:11 PM
 *   Author: li
 */ 

.include "m2560def.inc"
ldi R30, $01
LDI R16, 0

LOOP:
    
	mov R17, R30
	adiw z, 1
	mov R18, R30
	adiw z, 1
	;add R18, R17
	
    INC R16

    CPI R16, 3
    BRNE LOOP  







