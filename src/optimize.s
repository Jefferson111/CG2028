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
 	MOV R6, #0
 	ADD R1, R1 @R1 = 2a
 	LDR R5, LAMBDA @Loads lambda into R5
loop:
 	ADD R6, #1
 	MOV R4, R0 @Store old value of X into oldX/R4
 	MLA R7, R1, R0, R2 @Fp = 2ax + b
 	SDIV R7, R5 @DELTA = Fp / lambda
 	SUB R0, R7 @Update X/R0 into newX
 	TEQ R0, R4 @Equality
 	BNE loop @Loop condition
end:
 	STR R6, [R3]
 	POP {R4-R7}
 	BX	LR

@ Define constant values
CONST: .word 123
LAMBDA: .word 10
