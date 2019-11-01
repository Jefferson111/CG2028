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
 	MOV R6, #0 @Initialise counter with 0
 	ADD R1, R1 @Set R1 to 2a
 	LDR R5, LAMBDA @Loads lambda into R5
loop:
 	ADD R6, #1 @Increment counter
 	MOV R4, R0 @Store old value of x into R4
 	MLA R7, R1, R0, R2 @Calculates Fp = 2ax + b
 	SDIV R7, R5 @Calculates DELTA = Fp / lambda
 	SUB R0, R7 @Update value of x
 	TEQ R0, R4 @Test equality of old value and new value of x
 	BNE loop @Loop condition
end:
 	STR R6, [R3] @Store the number of iterations
 	POP {R4-R7}
 	BX	LR

@ Define constant values
CONST: .word 123
LAMBDA: .word 10
