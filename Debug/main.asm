   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 1
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.file	"main.c"
  15              		.text
  16              	.Ltext0:
  17              		.cfi_sections	.debug_frame
  18              		.section	.rodata
  19              		.align	2
  20              	.LC0:
  21 0000 496E6974 		.ascii	"Initial value of x (press [Enter] after keying in):"
  21      69616C20 
  21      76616C75 
  21      65206F66 
  21      20782028 
  22 0033 2000     		.ascii	" \000"
  23 0035 000000   		.align	2
  24              	.LC1:
  25 0038 256600   		.ascii	"%f\000"
  26 003b 00       		.align	2
  27              	.LC2:
  28 003c 41524D20 		.ascii	"ARM ASM & Integer version:\012\000"
  28      41534D20 
  28      2620496E 
  28      74656765 
  28      72207665 
  29              		.global	__aeabi_f2iz
  30              		.global	__aeabi_i2d
  31              		.global	__aeabi_ddiv
  32              		.global	__aeabi_d2f
  33              		.align	2
  34              	.LC3:
  35 0058 78736F6C 		.ascii	"xsol : %f \012\012\000"
  35      203A2025 
  35      66200A0A 
  35      00
  36              		.global	__aeabi_f2d
  37 0065 000000   		.align	2
  38              	.LC4:
  39 0068 4E756D62 		.ascii	"Number of iterations : %d\012\012\000"
  39      6572206F 
  39      66206974 
  39      65726174 
  39      696F6E73 
  40              		.align	2
  41              	.LC5:
  42 0084 43202620 		.ascii	"C & Floating point version:\012\000"
  42      466C6F61 
  42      74696E67 
  42      20706F69 
  42      6E742076 
  43              		.global	__aeabi_i2f
  44              		.global	__aeabi_fmul
  45              		.global	__aeabi_fadd
  46 00a1 000000   		.align	2
  47              	.LC6:
  48 00a4 783A2025 		.ascii	"x: %f, fp: %f, change: %f\012\000"
  48      662C2066 
  48      703A2025 
  48      662C2063 
  48      68616E67 
  49              		.global	__aeabi_fcmpeq
  50 00bf 00       		.section	.text.main,"ax",%progbits
  51              		.align	2
  52              		.global	main
  53              		.thumb
  54              		.thumb_func
  56              	main:
  57              	.LFB0:
  58              		.file 1 "../src/main.c"
   1:../src/main.c **** #include "stdio.h"
   2:../src/main.c **** 
   3:../src/main.c **** // CG2028 Assignment
   4:../src/main.c **** // (C) CK Tham, ECE, NUS
   5:../src/main.c **** 
   6:../src/main.c **** /** Authors:
   7:../src/main.c ****  * Alex Teo Kang Jie, A0180338E
   8:../src/main.c ****  * Chu Jui Hung @Jefferson Chu, A0182590B
   9:../src/main.c ****  *  Optimization routine written in assembly language
  10:../src/main.c ****  *  Input parameters (signed integers):
  11:../src/main.c ****  *     xi : integer version of x
  12:../src/main.c ****  *        a, b, c: integer coefficients of f(x)
  13:../src/main.c ****  *        Output : returns solution x (signed integer)
  14:../src/main.c ****  *        iter: number of iterations
  15:../src/main.c ****  */
  16:../src/main.c **** extern int optimize(int xi, int a, int b, int c);
  17:../src/main.c **** 
  18:../src/main.c **** int main(void)
  19:../src/main.c **** {
  59              		.loc 1 19 0
  60              		.cfi_startproc
  61              		@ args = 0, pretend = 0, frame = 48
  62              		@ frame_needed = 1, uses_anonymous_args = 0
  63 0000 2DE9904F 		push	{r4, r7, r8, r9, sl, fp, lr}
  64              	.LCFI0:
  65              		.cfi_def_cfa_offset 28
  66              		.cfi_offset 14, -4
  67              		.cfi_offset 11, -8
  68              		.cfi_offset 10, -12
  69              		.cfi_offset 9, -16
  70              		.cfi_offset 8, -20
  71              		.cfi_offset 7, -24
  72              		.cfi_offset 4, -28
  73 0004 91B0     		sub	sp, sp, #68
  74              	.LCFI1:
  75              		.cfi_def_cfa_offset 96
  76 0006 04AF     		add	r7, sp, #16
  77              	.LCFI2:
  78              		.cfi_def_cfa 7, 80
  20:../src/main.c ****     int a=10, b=4, c=-3, xsoli;
  79              		.loc 1 20 0
  80 0008 4FF00A03 		mov	r3, #10
  81 000c FB62     		str	r3, [r7, #44]
  82 000e 4FF00403 		mov	r3, #4
  83 0012 BB62     		str	r3, [r7, #40]
  84 0014 6FF00203 		mvn	r3, #2
  85 0018 7B62     		str	r3, [r7, #36]
  21:../src/main.c ****     int iter = 0;
  86              		.loc 1 21 0
  87 001a 4FF00003 		mov	r3, #0
  88 001e BB60     		str	r3, [r7, #8]
  22:../src/main.c ****     float fp, x, xprev, xsol, change, lambda=0.1;
  89              		.loc 1 22 0
  90 0020 634B     		ldr	r3, .L7	@ float
  91 0022 3B62     		str	r3, [r7, #32]	@ float
  23:../src/main.c **** 
  24:../src/main.c ****     printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
  92              		.loc 1 24 0
  93 0024 40F20003 		movw	r3, #:lower16:.LC0
  94 0028 C0F20003 		movt	r3, #:upper16:.LC0
  95 002c 1846     		mov	r0, r3
  96 002e FFF7FEFF 		bl	printf
  25:../src/main.c ****     scanf("%f", &x);
  97              		.loc 1 25 0
  98 0032 40F20003 		movw	r3, #:lower16:.LC1
  99 0036 C0F20003 		movt	r3, #:upper16:.LC1
 100 003a 07F10402 		add	r2, r7, #4
 101 003e 1846     		mov	r0, r3
 102 0040 1146     		mov	r1, r2
 103 0042 FFF7FEFF 		bl	scanf
  26:../src/main.c **** 
  27:../src/main.c **** //  ARM ASM & Integer version
  28:../src/main.c ****     printf("ARM ASM & Integer version:\n");
 104              		.loc 1 28 0
 105 0046 40F20003 		movw	r3, #:lower16:.LC2
 106 004a C0F20003 		movt	r3, #:upper16:.LC2
 107 004e 1846     		mov	r0, r3
 108 0050 FFF7FEFF 		bl	printf
  29:../src/main.c ****     xsoli = optimize((int) x * 100, a, 100 * b, &iter); //scaling of 100
 109              		.loc 1 29 0
 110 0054 7B68     		ldr	r3, [r7, #4]	@ float
 111 0056 1846     		mov	r0, r3
 112 0058 FFF7FEFF 		bl	__aeabi_f2iz
 113 005c 0346     		mov	r3, r0
 114 005e 4FF06402 		mov	r2, #100
 115 0062 02FB03F1 		mul	r1, r2, r3
 116 0066 BB6A     		ldr	r3, [r7, #40]
 117 0068 4FF06402 		mov	r2, #100
 118 006c 02FB03F2 		mul	r2, r2, r3
 119 0070 07F10803 		add	r3, r7, #8
 120 0074 0846     		mov	r0, r1
 121 0076 F96A     		ldr	r1, [r7, #44]
 122 0078 FFF7FEFF 		bl	optimize
 123 007c 0346     		mov	r3, r0
 124 007e FB61     		str	r3, [r7, #28]
  30:../src/main.c ****     xsol = xsoli / 100.0;
 125              		.loc 1 30 0
 126 0080 F869     		ldr	r0, [r7, #28]
 127 0082 FFF7FEFF 		bl	__aeabi_i2d
 128 0086 0246     		mov	r2, r0
 129 0088 0B46     		mov	r3, r1
 130 008a 1046     		mov	r0, r2
 131 008c 1946     		mov	r1, r3
 132 008e 4FF00002 		mov	r2, #0
 133 0092 4FF08043 		mov	r3, #1073741824
 134 0096 03F5B203 		add	r3, r3, #5832704
 135 009a FFF7FEFF 		bl	__aeabi_ddiv
 136 009e 0246     		mov	r2, r0
 137 00a0 0B46     		mov	r3, r1
 138 00a2 1046     		mov	r0, r2
 139 00a4 1946     		mov	r1, r3
 140 00a6 FFF7FEFF 		bl	__aeabi_d2f
 141 00aa 0346     		mov	r3, r0
 142 00ac BB61     		str	r3, [r7, #24]	@ float
  31:../src/main.c ****     printf("xsol : %f \n\n",xsol);
 143              		.loc 1 31 0
 144 00ae 40F20004 		movw	r4, #:lower16:.LC3
 145 00b2 C0F20004 		movt	r4, #:upper16:.LC3
 146 00b6 B869     		ldr	r0, [r7, #24]	@ float
 147 00b8 FFF7FEFF 		bl	__aeabi_f2d
 148 00bc 0246     		mov	r2, r0
 149 00be 0B46     		mov	r3, r1
 150 00c0 2046     		mov	r0, r4
 151 00c2 FFF7FEFF 		bl	printf
  32:../src/main.c ****     printf("Number of iterations : %d\n\n", iter);
 152              		.loc 1 32 0
 153 00c6 40F20003 		movw	r3, #:lower16:.LC4
 154 00ca C0F20003 		movt	r3, #:upper16:.LC4
 155 00ce BA68     		ldr	r2, [r7, #8]
 156 00d0 1846     		mov	r0, r3
 157 00d2 1146     		mov	r1, r2
 158 00d4 FFF7FEFF 		bl	printf
  33:../src/main.c **** 
  34:../src/main.c **** //  NOTE: You DO NOT need to modify the code below this line
  35:../src/main.c **** 
  36:../src/main.c **** //  C & Floating Point version
  37:../src/main.c ****   	printf("C & Floating point version:\n",x);
 159              		.loc 1 37 0
 160 00d8 40F20004 		movw	r4, #:lower16:.LC5
 161 00dc C0F20004 		movt	r4, #:upper16:.LC5
 162 00e0 7B68     		ldr	r3, [r7, #4]	@ float
 163 00e2 1846     		mov	r0, r3
 164 00e4 FFF7FEFF 		bl	__aeabi_f2d
 165 00e8 0246     		mov	r2, r0
 166 00ea 0B46     		mov	r3, r1
 167 00ec 2046     		mov	r0, r4
 168 00ee FFF7FEFF 		bl	printf
 169              	.L5:
  38:../src/main.c ****     while (1)
  39:../src/main.c ****     {
  40:../src/main.c ****     	fp = 2*a*x + b;
 170              		.loc 1 40 0
 171 00f2 FB6A     		ldr	r3, [r7, #44]
 172 00f4 4FEA4303 		lsl	r3, r3, #1
 173 00f8 1846     		mov	r0, r3
 174 00fa FFF7FEFF 		bl	__aeabi_i2f
 175 00fe 0246     		mov	r2, r0
 176 0100 7B68     		ldr	r3, [r7, #4]	@ float
 177 0102 1046     		mov	r0, r2
 178 0104 1946     		mov	r1, r3
 179 0106 FFF7FEFF 		bl	__aeabi_fmul
 180 010a 0346     		mov	r3, r0
 181 010c 1C46     		mov	r4, r3
 182 010e B86A     		ldr	r0, [r7, #40]
 183 0110 FFF7FEFF 		bl	__aeabi_i2f
 184 0114 0346     		mov	r3, r0
 185 0116 2046     		mov	r0, r4
 186 0118 1946     		mov	r1, r3
 187 011a FFF7FEFF 		bl	__aeabi_fadd
 188 011e 0346     		mov	r3, r0
 189 0120 7B61     		str	r3, [r7, #20]	@ float
  41:../src/main.c **** 
  42:../src/main.c ****     	xprev = x;
 190              		.loc 1 42 0
 191 0122 7B68     		ldr	r3, [r7, #4]	@ float
 192 0124 3B61     		str	r3, [r7, #16]	@ float
  43:../src/main.c ****     	change = -lambda*fp;
 193              		.loc 1 43 0
 194 0126 3B6A     		ldr	r3, [r7, #32]
 195 0128 83F00043 		eor	r3, r3, #-2147483648
 196 012c 1846     		mov	r0, r3
 197 012e 7969     		ldr	r1, [r7, #20]	@ float
 198 0130 FFF7FEFF 		bl	__aeabi_fmul
 199 0134 0346     		mov	r3, r0
 200 0136 FB60     		str	r3, [r7, #12]	@ float
  44:../src/main.c ****     	x += change;
 201              		.loc 1 44 0
 202 0138 7B68     		ldr	r3, [r7, #4]	@ float
 203 013a 1846     		mov	r0, r3
 204 013c F968     		ldr	r1, [r7, #12]	@ float
 205 013e FFF7FEFF 		bl	__aeabi_fadd
 206 0142 0346     		mov	r3, r0
 207 0144 7B60     		str	r3, [r7, #4]	@ float
  45:../src/main.c **** 
  46:../src/main.c ****     	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
 208              		.loc 1 46 0
 209 0146 40F20004 		movw	r4, #:lower16:.LC6
 210 014a C0F20004 		movt	r4, #:upper16:.LC6
 211 014e 7B68     		ldr	r3, [r7, #4]	@ float
 212 0150 1846     		mov	r0, r3
 213 0152 FFF7FEFF 		bl	__aeabi_f2d
 214 0156 8046     		mov	r8, r0
 215 0158 8946     		mov	r9, r1
 216 015a 7869     		ldr	r0, [r7, #20]	@ float
 217 015c FFF7FEFF 		bl	__aeabi_f2d
 218 0160 8246     		mov	sl, r0
 219 0162 8B46     		mov	fp, r1
 220 0164 F868     		ldr	r0, [r7, #12]	@ float
 221 0166 FFF7FEFF 		bl	__aeabi_f2d
 222 016a 0246     		mov	r2, r0
 223 016c 0B46     		mov	r3, r1
 224 016e CDE900AB 		strd	sl, [sp]
 225 0172 CDE90223 		strd	r2, [sp, #8]
 226 0176 2046     		mov	r0, r4
 227 0178 4246     		mov	r2, r8
 228 017a 4B46     		mov	r3, r9
 229 017c FFF7FEFF 		bl	printf
  47:../src/main.c ****     	if (x==xprev) break;
 230              		.loc 1 47 0
 231 0180 7B68     		ldr	r3, [r7, #4]	@ float
 232 0182 1846     		mov	r0, r3
 233 0184 3969     		ldr	r1, [r7, #16]	@ float
 234 0186 FFF7FEFF 		bl	__aeabi_fcmpeq
 235 018a 0346     		mov	r3, r0
 236 018c 002B     		cmp	r3, #0
 237 018e 00D1     		bne	.L6
  48:../src/main.c ****     }
 238              		.loc 1 48 0
 239 0190 AFE7     		b	.L5
 240              	.L6:
  47:../src/main.c ****     	if (x==xprev) break;
 241              		.loc 1 47 0
 242 0192 00BF     		nop
 243              	.L4:
  49:../src/main.c **** 
  50:../src/main.c ****     // Enter an infinite loop, just incrementing a counter
  51:../src/main.c **** 	// This is for convenience to allow registers, variables and memory locations to be inspected at t
  52:../src/main.c **** 	volatile static int loop = 0;
  53:../src/main.c **** 	while (1) {
  54:../src/main.c **** 		loop++;
 244              		.loc 1 54 0 discriminator 1
 245 0194 40F20003 		movw	r3, #:lower16:loop.3827
 246 0198 C0F20003 		movt	r3, #:upper16:loop.3827
 247 019c 1B68     		ldr	r3, [r3, #0]
 248 019e 03F10102 		add	r2, r3, #1
 249 01a2 40F20003 		movw	r3, #:lower16:loop.3827
 250 01a6 C0F20003 		movt	r3, #:upper16:loop.3827
 251 01aa 1A60     		str	r2, [r3, #0]
  55:../src/main.c **** 	}
 252              		.loc 1 55 0 discriminator 1
 253 01ac F2E7     		b	.L4
 254              	.L8:
 255 01ae 00BF     		.align	2
 256              	.L7:
 257 01b0 CDCCCC3D 		.word	1036831949
 258              		.cfi_endproc
 259              	.LFE0:
 261              		.bss
 262              		.align	2
 263              	loop.3827:
 264 0000 00000000 		.space	4
 265              		.text
 266              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:19     .rodata:00000000 $d
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:20     .rodata:00000000 .LC0
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:24     .rodata:00000038 .LC1
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:27     .rodata:0000003c .LC2
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:34     .rodata:00000058 .LC3
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:38     .rodata:00000068 .LC4
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:41     .rodata:00000084 .LC5
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:47     .rodata:000000a4 .LC6
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:51     .text.main:00000000 $t
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:56     .text.main:00000000 main
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:263    .bss:00000000 loop.3827
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:257    .text.main:000001b0 $d
C:\Users\jeffe\AppData\Local\Temp\cc7wo8oO.s:262    .bss:00000000 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
__aeabi_f2iz
__aeabi_i2d
__aeabi_ddiv
__aeabi_d2f
__aeabi_f2d
__aeabi_i2f
__aeabi_fmul
__aeabi_fadd
__aeabi_fcmpeq
printf
scanf
optimize
