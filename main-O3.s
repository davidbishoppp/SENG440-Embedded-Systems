	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	printU128
	.arch armv6
	.syntax unified
	.arm
	.fpu neon
	.type	printU128, %function
printU128:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #20
	ldr	r3, .L4
	vstr.64	d1, [sp, #8]	@ int
	vstr.64	d0, [sp]	@ int
	mov	r2, r0
	ldr	r1, .L4+4
	ldr	r0, [r3]
	bl	fprintf
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L5:
	.align	2
.L4:
	.word	stderr
	.word	.LC0
	.size	printU128, .-printU128
	.align	2
	.global	greaterThanEqual
	.syntax unified
	.arm
	.fpu neon
	.type	greaterThanEqual, %function
greaterThanEqual:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	r0, r1, d1  @ v2di
	vmov	r2, r3, d3  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	movcs	r0, #1
	movcc	r0, #0
	bx	lr
	.size	greaterThanEqual, .-greaterThanEqual
	.align	2
	.global	equal
	.syntax unified
	.arm
	.fpu neon
	.type	equal, %function
equal:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	r0, r1, d1  @ v2di
	vmov	r2, r3, d3  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	movne	r0, #0
	push	{r4, r5}
	moveq	r0, #1
	vmov	r4, r5, d0  @ v2di
	vmov	r2, r3, d2  @ v2di
	cmp	r5, r3
	cmpeq	r4, r2
	movne	r0, #0
	pop	{r4, r5}
	bx	lr
	.size	equal, .-equal
	.align	2
	.global	MMM
	.syntax unified
	.arm
	.fpu neon
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	vldr	d16, .L26
	vldr	d17, .L26+8
	sub	sp, sp, #20
	vmov	r6, r7, d2  @ v2di
	vst1.64	{d16-d17}, [sp:64]
	mov	ip, #126
	vld1.64	{d18-d19}, [sp:64]
	mov	lr, r6
	vmov.i32	q8, #0  @ v2di
	vmov	r4, r5, d18  @ v2di
	b	.L15
.L25:
	vmov	r8, r9, d17  @ v2di
.L12:
	vmov	r2, r3, d1  @ v2di
	mov	r1, #0
	and	r0, r2, #1
	orrs	r3, r0, r1
	vshr.u64	q0, q0, #1
	beq	.L13
	vmov	r2, r3, d0  @ v2di
	mov	r0, r2
	orr	r1, r3, #-2147483648
	vmov	d0, r0, r1
.L13:
	and	r2, r8, #1
	mov	r3, #0
	orrs	r3, r2, r3
	vshr.u64	q8, q8, #1
	beq	.L14
	vmov	r0, r1, d16  @ v2di
	mov	r2, r0
	orr	r3, r1, #-2147483648
	vmov	d16, r2, r3
.L14:
	subs	ip, ip, #1
	beq	.L24
.L15:
	vmov	r2, r3, d0  @ v2di
	and	r3, r2, #1
	and	r2, r3, lr
	vmov	r0, r1, d16  @ v2di
	and	r0, r0, #1
	cmp	r2, r0
	beq	.L10
	vadd.i64	q8, q8, q9
	vmov	r0, r1, d16  @ v2di
	cmp	r1, r5
	cmpeq	r0, r4
	bcs	.L10
	vmov	r8, r9, d17  @ v2di
	adds	r0, r8, #1
	adc	r1, r9, #0
	vmov	d17, r0, r1
.L10:
	cmp	r3, #0
	beq	.L25
	vadd.i64	q8, q8, q1
	vmov	r2, r3, d16  @ v2di
	cmp	r7, r3
	cmpeq	r6, r2
	vmov	r8, r9, d17  @ v2di
	bls	.L12
	adds	r8, r8, #1
	adc	r9, r9, #0
	vmov	d17, r8, r9
	b	.L12
.L24:
	vmov	r2, r3, d17  @ v2di
	vmov	r0, r1, d19  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	bcc	.L9
	vmov	r2, r3, d16  @ v2di
	vsub.i64	q9, q8, q9
	vmov	r0, r1, d18  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L18
	vmov	r0, r1, d19  @ v2di
	subs	r2, r0, #1
	sbc	r3, r1, #0
	vmov	q8, q9  @ v2di
	vmov	d17, r2, r3
.L9:
	vmov	q0, q8  @ v2di
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L18:
	vmov	q8, q9  @ v2di
	vmov	q0, q8  @ v2di
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L27:
	.align	3
.L26:
	.word	176625
	.word	0
	.word	-423
	.word	1073741823
	.size	MMM, .-MMM
	.align	2
	.global	MMM_1
	.syntax unified
	.arm
	.fpu neon
	.type	MMM_1, %function
MMM_1:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	r2, r3, d0  @ v2di
	and	r1, r2, #1
	cmp	r1, #0
	push	{r4, r5, r6, r7}
	vldr	d16, .L53
	vldr	d17, .L53+8
	sub	sp, sp, #16
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d18-d19}, [sp:64]
	beq	.L51
	vmov	q8, q9  @ v2di
.L29:
	vadd.i64	q0, q8, q0
	vmov	r0, r1, d0  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	vmov	r0, r1, d1  @ v2di
	bls	.L30
	adds	r0, r0, #1
	adc	r1, r1, #0
	vmov	d1, r0, r1
.L30:
	and	r2, r0, #1
	mov	r3, #0
	orrs	r3, r2, r3
	vshr.u64	q0, q0, #1
	beq	.L31
	vmov	r0, r1, d0  @ v2di
	mov	r2, r0
	orr	r3, r1, #-2147483648
	vmov	d0, r2, r3
.L31:
	vcnt.8	q8, q0
	vmov.u8	r3, d16[1]
	vmov.u8	r1, d16[0]
	add	r1, r1, r3
	vmov.u8	r3, d16[2]
	add	r1, r1, r3
	vmov.u8	r3, d16[3]
	add	r1, r1, r3
	vmov.u8	r3, d16[4]
	add	r1, r1, r3
	vmov.u8	r3, d16[5]
	add	r1, r1, r3
	vmov.u8	r3, d16[6]
	add	r1, r1, r3
	vmov.u8	r3, d16[7]
	adds	r1, r1, r3
	beq	.L32
	vmov	r4, r5, d18  @ v2di
.L35:
	vadd.i64	q0, q9, q0
	vmov	r2, r3, d0  @ v2di
	cmp	r3, r5
	cmpeq	r2, r4
	vmov	r6, r7, d1  @ v2di
	bcs	.L33
	adds	r6, r6, #1
	adc	r7, r7, #0
	vmov	d1, r6, r7
.L33:
	and	r2, r6, #1
	mov	r3, #0
	orrs	r3, r2, r3
	vshr.u64	q0, q0, #1
	beq	.L34
	vmov	r6, r7, d0  @ v2di
	mov	r2, r6
	orr	r3, r7, #-2147483648
	vmov	d0, r2, r3
.L34:
	subs	r1, r1, #1
	bne	.L35
.L32:
	vmov	r2, r3, d1  @ v2di
	vmov	r0, r1, d19  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	bcc	.L28
	vmov	r2, r3, d0  @ v2di
	vsub.i64	q9, q0, q9
	vmov	r0, r1, d18  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L37
	vmov	r0, r1, d19  @ v2di
	subs	r2, r0, #1
	sbc	r3, r1, #0
	vmov	d19, r2, r3
	vmov	q0, q9  @ v2di
.L28:
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7}
	bx	lr
.L51:
	vmov.i32	q8, #0  @ v2di
	b	.L29
.L37:
	vmov	q0, q9  @ v2di
	add	sp, sp, #16
	@ sp needed
	pop	{r4, r5, r6, r7}
	bx	lr
.L54:
	.align	3
.L53:
	.word	176625
	.word	0
	.word	-423
	.word	1073741823
	.size	MMM_1, .-MMM_1
	.align	2
	.global	ME_MMM
	.syntax unified
	.arm
	.fpu neon
	.type	ME_MMM, %function
ME_MMM:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	vmov	q13, q0  @ v2di
	sub	sp, sp, #20
	vldr	d16, .L68
	vldr	d17, .L68+8
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d22-d23}, [sp:64]
	vmov	q0, q11  @ v2di
	vmov	q10, q1  @ v2di
	bl	MMM_1
	vmov	q12, q0  @ v2di
	vmov	q1, q11  @ v2di
	vmov	q0, q13  @ v2di
	bl	MMM
	vmov	q11, q0  @ v2di
.L56:
	vmov	r2, r3, d20  @ v2di
	orrs	r3, r2, r3
	and	r1, r2, #1
	vmov	r6, r7, d21  @ v2di
	bne	.L59
	orrs	r3, r6, r7
	beq	.L67
.L57:
	vmov	q1, q11  @ v2di
	vmov	q0, q11  @ v2di
	bl	MMM
	and	r4, r6, #1
	mov	r5, #0
	orrs	r3, r4, r5
	vmov	q11, q0  @ v2di
	vshr.u64	q10, q10, #1
	beq	.L56
	vmov	r0, r1, d20  @ v2di
	mov	r2, r0
	orr	r3, r1, #-2147483648
	vmov	d20, r2, r3
	b	.L56
.L59:
	cmp	r1, #0
	vmov	q1, q11  @ v2di
	vmov	q0, q12  @ v2di
	beq	.L57
	bl	MMM
	vmov	q12, q0  @ v2di
	b	.L57
.L67:
	vmov	q0, q12  @ v2di
	bl	MMM_1
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L69:
	.align	3
.L68:
	.word	-727667363
	.word	-23
	.word	153323117
	.word	0
	.size	ME_MMM, .-ME_MMM
	.align	2
	.global	Encypt
	.syntax unified
	.arm
	.fpu neon
	.type	Encypt, %function
Encypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	vldr	d16, .L72
	vldr	d17, .L72+8
	sub	sp, sp, #20
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d2-d3}, [sp:64]
	bl	ME_MMM
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L73:
	.align	3
.L72:
	.word	463131873
	.word	1121068490
	.word	1046843180
	.word	947050211
	.size	Encypt, .-Encypt
	.align	2
	.global	Decrypt
	.syntax unified
	.arm
	.fpu neon
	.type	Decrypt, %function
Decrypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	vldr	d16, .L76
	vldr	d17, .L76+8
	sub	sp, sp, #20
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d2-d3}, [sp:64]
	bl	ME_MMM
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L77:
	.align	3
.L76:
	.word	-834791263
	.word	-370256966
	.word	-343159921
	.word	144194563
	.size	Decrypt, .-Decrypt
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	vpush.64	{d8}
	ldr	r1, .L85+40
	ldr	r0, .L85+44
	vldr.64	d8, .L85
	vpush.64	{d10, d11, d12, d13, d14, d15}
	ldr	r7, .L85+48
	vldr	d12, .L85+8
	vldr	d13, .L85+16
	vldr	d10, .L85+24
	vldr	d11, .L85+32
	sub	sp, sp, #56
	bl	fopen
	ldr	r1, .L85+52
	mov	r6, r0
	ldr	r0, .L85+56
	bl	fopen
	mov	r2, #16
	mov	r1, #1
	mov	r3, r0
	mov	r5, r0
	ldr	r0, .L85+60
	bl	fwrite
	bl	clock
	mov	r8, r0
.L79:
	mov	r2, r6
	mov	r1, #15
	add	r0, sp, #24
	bl	fgets
	cmp	r0, #0
	beq	.L84
	add	r3, sp, #24
	vld1.8	{d14-d15}, [r3:64]
	bl	clock
	add	r3, sp, #40
	vstr	d12, [sp, #40]
	vstr	d13, [sp, #48]
	vmov	q0, q7  @ v2di
	vld1.64	{d2-d3}, [r3:64]
	mov	r10, r0
	bl	ME_MMM
	add	r3, sp, #8
	vst1.64	{d0-d1}, [r3:64]
	bl	clock
	mov	r9, r0
	bl	clock
	add	r3, sp, #8
	vstr	d10, [sp, #40]
	vstr	d11, [sp, #48]
	vld1.64	{d0-d1}, [r3:64]
	add	r3, sp, #40
	vld1.64	{d2-d3}, [r3:64]
	sub	r9, r9, r10
	mov	r4, r0
	bl	ME_MMM
	add	r3, sp, #8
	vst1.64	{d0-d1}, [r3:64]
	bl	clock
	vmov	s15, r9	@ int
	mov	r1, r7
	vcvt.f64.s32	d16, s15
	vdiv.f64	d16, d16, d8
	sub	r4, r0, r4
	mov	r0, r5
	vmov	s15, r4	@ int
	vmov	r2, r3, d16
	vcvt.f64.s32	d16, s15
	vdiv.f64	d17, d16, d8
	vstr.64	d17, [sp]
	bl	fprintf
	vmov	r0, r1, d15  @ v2di
	add	r3, sp, #8
	vld1.64	{d0-d1}, [r3:64]
	vmov	r2, r3, d1  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	moveq	ip, #1
	vmov	r2, r3, d14  @ v2di
	vmov	r0, r1, d0  @ v2di
	movne	ip, #0
	cmp	r3, r1
	cmpeq	r2, r0
	movne	r3, #0
	moveq	r3, ip
	cmp	r3, #0
	bne	.L79
	ldr	r0, .L85+64
	bl	puts
.L80:
	mov	r0, #1
	add	sp, sp, #56
	@ sp needed
	vldm	sp!, {d10-d15}
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L84:
	bl	clock
	mov	r4, r0
	sub	r8, r4, r8
	mov	r0, r6
	bl	fclose
	mov	r0, r5
	bl	fclose
	vmov	s15, r8	@ int
	vldr.64	d17, .L85
	ldr	r0, .L85+68
	vcvt.f64.s32	d16, s15
	vdiv.f64	d16, d16, d17
	vmov	r2, r3, d16
	bl	printf
	b	.L80
.L86:
	.align	3
.L85:
	.word	0
	.word	1093567616
	.word	463131873
	.word	1121068490
	.word	1046843180
	.word	947050211
	.word	-834791263
	.word	-370256966
	.word	-343159921
	.word	144194563
	.word	.LC1
	.word	.LC2
	.word	.LC6
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC7
	.word	.LC8
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"%s - low: 0x%llx high: 0x%llx\012\000"
	.space	1
.LC1:
	.ascii	"r\000"
	.space	2
.LC2:
	.ascii	"./generator/inputs_new.txt\000"
	.space	1
.LC3:
	.ascii	"w+\000"
	.space	1
.LC4:
	.ascii	"./results/results.csv\000"
	.space	2
.LC5:
	.ascii	"encrypt,decrypt\012\000"
	.space	3
.LC6:
	.ascii	"%.7f,%.7f\012\000"
	.space	1
.LC7:
	.ascii	"NOT euqal!\000"
	.space	1
.LC8:
	.ascii	"loop time: %.20f\012\000"
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
