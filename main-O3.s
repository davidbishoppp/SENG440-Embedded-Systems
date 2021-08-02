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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	ip, #126
	vmov	r6, r7, d2  @ v2di
	vmov	r4, r5, d4  @ v2di
	mov	lr, r6
	vmov.i32	q8, #0  @ v2di
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
	vadd.i64	q8, q8, q2
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
	vmov	r0, r1, d5  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	bcc	.L9
	vmov	r2, r3, d16  @ v2di
	vsub.i64	q2, q8, q2
	vmov	r0, r1, d4  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L18
	vmov	r0, r1, d5  @ v2di
	subs	r2, r0, #1
	sbc	r3, r1, #0
	vmov	q8, q2  @ v2di
	vmov	d17, r2, r3
.L9:
	vmov	q0, q8  @ v2di
	pop	{r4, r5, r6, r7, r8, r9, pc}
.L18:
	vmov	q8, q2  @ v2di
	vmov	q0, q8  @ v2di
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	MMM, .-MMM
	.align	2
	.global	MMM_1
	.syntax unified
	.arm
	.fpu neon
	.type	MMM_1, %function
MMM_1:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	r2, r3, d0  @ v2di
	and	r1, r2, #1
	cmp	r1, #0
	push	{r4, r5}
	vmov	q8, q1  @ v2di
	bne	.L27
	vmov.i32	q8, #0  @ v2di
.L27:
	vadd.i64	q0, q8, q0
	vmov	r0, r1, d0  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	vmov	r0, r1, d1  @ v2di
	bls	.L28
	adds	r0, r0, #1
	adc	r1, r1, #0
	vmov	d1, r0, r1
.L28:
	and	r2, r0, #1
	mov	r3, #0
	orrs	r3, r2, r3
	vshr.u64	q0, q0, #1
	beq	.L29
	vmov	r0, r1, d0  @ v2di
	mov	r2, r0
	orr	r3, r1, #-2147483648
	vmov	d0, r2, r3
.L29:
	mov	ip, #125
	vmov	r0, r1, d2  @ v2di
	b	.L33
.L49:
	vmov	r4, r5, d1  @ v2di
.L31:
	and	r2, r4, #1
	mov	r3, #0
	orrs	r3, r2, r3
	vshr.u64	q0, q0, #1
	beq	.L32
	vmov	r4, r5, d0  @ v2di
	mov	r2, r4
	orr	r3, r5, #-2147483648
	vmov	d0, r2, r3
.L32:
	subs	ip, ip, #1
	beq	.L48
.L33:
	vmov	r2, r3, d0  @ v2di
	and	r2, r2, #1
	cmp	r2, #0
	beq	.L49
	vadd.i64	q0, q0, q1
	vmov	r2, r3, d0  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	vmov	r4, r5, d1  @ v2di
	bcs	.L31
	adds	r4, r4, #1
	adc	r5, r5, #0
	vmov	d1, r4, r5
	b	.L31
.L48:
	vmov	r2, r3, d1  @ v2di
	vmov	r0, r1, d3  @ v2di
	cmp	r3, r1
	cmpeq	r2, r0
	bcc	.L26
	vmov	r2, r3, d0  @ v2di
	vsub.i64	q1, q0, q1
	vmov	r0, r1, d2  @ v2di
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L35
	vmov	r0, r1, d3  @ v2di
	subs	r2, r0, #1
	sbc	r3, r1, #0
	vmov	d3, r2, r3
	vmov	q0, q1  @ v2di
.L26:
	pop	{r4, r5}
	bx	lr
.L35:
	vmov	q0, q1  @ v2di
	pop	{r4, r5}
	bx	lr
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
	vldr	d16, .L63
	vldr	d17, .L63+8
	sub	sp, sp, #20
	vldr	d20, .L63+16
	vldr	d21, .L63+24
	vst1.64	{d16-d17}, [sp:64]
	vmov	q11, q0  @ v2di
	vld1.64	{d26-d27}, [sp:64]
	vldr	d16, .L63+32
	vldr	d17, .L63+40
	vst1.64	{d20-d21}, [sp:64]
	vmov	q9, q1  @ v2di
	vld1.64	{d20-d21}, [sp:64]
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d24-d25}, [sp:64]
.L51:
	vmov	r2, r3, d18  @ v2di
	orrs	r3, r2, r3
	and	r1, r2, #1
	vmov	r6, r7, d19  @ v2di
	bne	.L54
	orrs	r3, r6, r7
	beq	.L62
.L52:
	vmov	q0, q11  @ v2di
	vmov	q2, q10  @ v2di
	vmov	q1, q12  @ v2di
	bl	MMM
	and	r4, r6, #1
	mov	r5, #0
	vmov	q2, q10  @ v2di
	vmov	q1, q0  @ v2di
	bl	MMM
	vmov	q1, q10  @ v2di
	bl	MMM_1
	orrs	r3, r4, r5
	vmov	q11, q0  @ v2di
	vshr.u64	q9, q9, #1
	beq	.L51
	vmov	r0, r1, d18  @ v2di
	mov	r2, r0
	orr	r3, r1, #-2147483648
	vmov	d18, r2, r3
	b	.L51
.L54:
	cmp	r1, #0
	vmov	q0, q11  @ v2di
	vmov	q2, q10  @ v2di
	vmov	q1, q12  @ v2di
	beq	.L52
	bl	MMM
	vmov	q14, q0  @ v2di
	vmov	q2, q10  @ v2di
	vmov	q0, q13  @ v2di
	bl	MMM
	vmov	q1, q0  @ v2di
	vmov	q2, q10  @ v2di
	vmov	q0, q14  @ v2di
	bl	MMM
	vmov	q1, q10  @ v2di
	bl	MMM_1
	vmov	q13, q0  @ v2di
	b	.L52
.L62:
	vmov	q0, q13  @ v2di
	add	sp, sp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L64:
	.align	3
.L63:
	.word	1
	.word	0
	.word	0
	.word	0
	.word	176625
	.word	0
	.word	-423
	.word	1073741823
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
	vldr	d16, .L67
	vldr	d17, .L67+8
	sub	sp, sp, #20
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d2-d3}, [sp:64]
	bl	ME_MMM
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L68:
	.align	3
.L67:
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
	vldr	d16, .L71
	vldr	d17, .L71+8
	sub	sp, sp, #20
	vst1.64	{d16-d17}, [sp:64]
	vld1.64	{d2-d3}, [sp:64]
	bl	ME_MMM
	add	sp, sp, #20
	@ sp needed
	ldr	pc, [sp], #4
.L72:
	.align	3
.L71:
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
	ldr	r1, .L80+40
	ldr	r0, .L80+44
	vldr.64	d8, .L80
	vpush.64	{d10, d11, d12, d13, d14, d15}
	ldr	r7, .L80+48
	vldr	d12, .L80+8
	vldr	d13, .L80+16
	vldr	d10, .L80+24
	vldr	d11, .L80+32
	sub	sp, sp, #56
	bl	fopen
	ldr	r1, .L80+52
	mov	r6, r0
	ldr	r0, .L80+56
	bl	fopen
	mov	r2, #16
	mov	r1, #1
	mov	r3, r0
	mov	r5, r0
	ldr	r0, .L80+60
	bl	fwrite
	bl	clock
	mov	r8, r0
.L74:
	mov	r2, r6
	mov	r1, #15
	add	r0, sp, #24
	bl	fgets
	cmp	r0, #0
	beq	.L79
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
	bne	.L74
	ldr	r0, .L80+64
	bl	puts
.L75:
	mov	r0, #1
	add	sp, sp, #56
	@ sp needed
	vldm	sp!, {d10-d15}
	vldm	sp!, {d8}
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.L79:
	bl	clock
	mov	r4, r0
	sub	r8, r4, r8
	mov	r0, r6
	bl	fclose
	mov	r0, r5
	bl	fclose
	vmov	s15, r8	@ int
	vldr.64	d17, .L80
	ldr	r0, .L80+68
	vcvt.f64.s32	d16, s15
	vdiv.f64	d16, d16, d17
	vmov	r2, r3, d16
	bl	printf
	b	.L75
.L81:
	.align	3
.L80:
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
