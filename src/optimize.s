 	.syntax unified
 	.cpu cortex-m3
 	.thumb
 	.align 2
 	.global	optimize
 	.thumb_func
@  EE2024 Assignment 1 skeleton
@  CK Tham, ECE, NUS
optimize:
@  Write optimization function in assembly language here
@  Currently, nothing is done and this function returns straightaway
 	PUSH {R4-R7}
 	MOV R6, #0 @Initialise counter with 0                           0x03A06000
 	ADD R1, R1 @Set R1 to 2a                                        0x00811001
 	LDR R5, LAMBDA @Loads lambda into R5
loop:
 	ADD R6, #1 @Increment counter                                   0x02866001
 	MOV R4, R0 @Store old value of x into R4                        0x01A04000
 	MLA R7, R1, R0, R2 @Calculates Fp = 2ax + b                     0x00227011
 	SDIV R7, R5 @Calculates DELTA = Fp / lambda
 	SUB R0, R7 @Update value of x                                   0x00400007
 	TEQ R0, R4 @Test equality of old value and new value of x       0x01300004
 	BNE loop @Loop condition                                        0x1800000C
end:
 	STR R6, [R3, #0] @Store the number of iterations                0x05837000
 	POP {R4-R7}
 	BX	LR

@ Define constant values
CONST: .word 123
LAMBDA: .word 10
