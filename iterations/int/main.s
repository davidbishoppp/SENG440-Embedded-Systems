	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	bitLength
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	bitLength, %function
bitLength:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #20
	strd	r0, [fp, #-28]
	mov	r2, #0
	mov	r3, #0
	strd	r2, [fp, #-20]
	b	.L2
.L3:
	ldrd	r2, [fp, #-20]
	adds	r4, r2, #1
	adc	r5, r3, #0
	strd	r4, [fp, #-20]
	ldrd	r0, [fp, #-28]
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	strd	r2, [fp, #-28]
.L2:
	ldrd	r2, [fp, #-28]
	orrs	r3, r2, r3
	bne	.L3
	ldrd	r2, [fp, #-20]
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, r5, fp}
	bx	lr
	.size	bitLength, .-bitLength
	.align	2
	.global	MMM
	.syntax unified
	.arm
	.fpu vfp
	.type	MMM, %function
MMM:
	@ args = 8, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, r6, r7, r8, r9, fp}
	add	fp, sp, #24
	sub	sp, sp, #84
	strd	r0, [fp, #-60]
	strd	r2, [fp, #-68]
	ldrd	r2, [fp, #4]
	strd	r2, [fp, #-44]
	mov	r2, #0
	mov	r3, #0
	strd	r2, [fp, #-36]
	b	.L6
.L7:
	ldrd	r0, [fp, #-60]
	ldrd	r2, [fp, #-68]
	and	ip, r0, r2
	str	ip, [fp, #-76]
	and	r3, r1, r3
	str	r3, [fp, #-72]
	ldrd	r2, [fp, #-36]
	ldrd	r0, [fp, #-76]
	mov	ip, r0
	eor	ip, ip, r2
	str	ip, [fp, #-84]
	eor	r3, r1, r3
	str	r3, [fp, #-80]
	mov	r2, #1
	mov	r3, #0
	ldrd	r0, [fp, #-84]
	mov	ip, r0
	and	ip, ip, r2
	str	ip, [fp, #-100]
	and	r3, r1, r3
	str	r3, [fp, #-96]
	ldrd	r2, [fp, #-100]
	strd	r2, [fp, #-52]
	ldrd	r0, [fp, #-60]
	mov	r2, #1
	mov	r3, #0
	and	r6, r0, r2
	and	r7, r1, r3
	ldr	r3, [fp, #-68]
	mul	r2, r7, r3
	ldr	r3, [fp, #-64]
	mul	r3, r6, r3
	add	r2, r2, r3
	ldr	r3, [fp, #-68]
	umull	r4, r5, r3, r6
	add	r3, r2, r5
	mov	r5, r3
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-44]
	mul	r1, r3, r2
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-52]
	mul	r3, r3, r2
	add	r1, r1, r3
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-44]
	umull	r2, r3, r2, r3
	add	r1, r1, r3
	mov	r3, r1
	adds	r1, r4, r2
	str	r1, [fp, #-92]
	adc	r3, r5, r3
	str	r3, [fp, #-88]
	ldrd	r2, [fp, #-36]
	ldrd	r0, [fp, #-92]
	mov	ip, r0
	adds	r8, ip, r2
	adc	r9, r1, r3
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r8, #1
	orr	r2, r2, r9, lsl #31
	lsr	r3, r9, #1
	strd	r2, [fp, #-36]
	ldrd	r2, [fp, #4]
	mov	r0, #0
	mov	r1, #0
	lsr	r0, r2, #1
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	strd	r0, [fp, #4]
	ldrd	r2, [fp, #-60]
	mov	r0, #0
	mov	r1, #0
	lsr	r0, r2, #1
	orr	r0, r0, r3, lsl #31
	lsr	r1, r3, #1
	strd	r0, [fp, #-60]
.L6:
	ldrd	r2, [fp, #4]
	orrs	r3, r2, r3
	bne	.L7
	ldrd	r0, [fp, #-36]
	ldrd	r2, [fp, #-44]
	cmp	r1, r3
	cmpeq	r0, r2
	bcc	.L8
	ldrd	r0, [fp, #-36]
	ldrd	r2, [fp, #-44]
	subs	ip, r0, r2
	str	ip, [fp, #-108]
	sbc	r3, r1, r3
	str	r3, [fp, #-104]
	ldrd	r2, [fp, #-108]
	strd	r2, [fp, #-36]
.L8:
	ldrd	r2, [fp, #-36]
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp}
	bx	lr
	.size	MMM, .-MMM
	.align	2
	.global	MMM_without_scale
	.syntax unified
	.arm
	.fpu vfp
	.type	MMM_without_scale, %function
MMM_without_scale:
	@ args = 16, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #56
	strd	r0, [fp, #-44]
	strd	r2, [fp, #-52]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	ldrd	r2, [fp, #12]
	ldrd	r0, [fp, #-44]
	bl	MMM
	strd	r0, [fp, #-12]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	ldrd	r2, [fp, #12]
	ldrd	r0, [fp, #-52]
	bl	MMM
	strd	r0, [fp, #-20]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	ldrd	r2, [fp, #-20]
	ldrd	r0, [fp, #-12]
	bl	MMM
	strd	r0, [fp, #-28]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	mov	r2, #1
	mov	r3, #0
	ldrd	r0, [fp, #-28]
	bl	MMM
	strd	r0, [fp, #-36]
	ldrd	r2, [fp, #-36]
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	MMM_without_scale, .-MMM_without_scale
	.align	2
	.global	ME_MMM
	.syntax unified
	.arm
	.fpu vfp
	.type	ME_MMM, %function
ME_MMM:
	@ args = 16, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #40
	strd	r0, [fp, #-28]
	strd	r2, [fp, #-36]
	mov	r2, #1
	mov	r3, #0
	strd	r2, [fp, #-20]
	b	.L13
.L15:
	ldrd	r2, [fp, #-36]
	mov	r0, #1
	mov	r1, #0
	and	r4, r2, r0
	and	r5, r3, r1
	orrs	r3, r4, r5
	beq	.L14
	ldrd	r2, [fp, #12]
	strd	r2, [sp, #8]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	ldrd	r2, [fp, #-20]
	ldrd	r0, [fp, #-28]
	bl	MMM_without_scale
	strd	r0, [fp, #-20]
.L14:
	ldrd	r2, [fp, #12]
	strd	r2, [sp, #8]
	ldrd	r2, [fp, #4]
	strd	r2, [sp]
	ldrd	r2, [fp, #-28]
	ldrd	r0, [fp, #-28]
	bl	MMM_without_scale
	strd	r0, [fp, #-28]
	ldrd	r0, [fp, #-36]
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	strd	r2, [fp, #-36]
.L13:
	ldrd	r2, [fp, #-36]
	orrs	r3, r2, r3
	bne	.L15
	ldrd	r2, [fp, #-20]
	mov	r0, r2
	mov	r1, r3
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	ME_MMM, .-ME_MMM
	.align	2
	.global	copyStr
	.syntax unified
	.arm
	.fpu vfp
	.type	copyStr, %function
copyStr:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #16
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	ldr	r0, [fp, #-28]
	bl	strlen
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L18
.L20:
	ldr	r3, [fp, #-24]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-28]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxtb	r2, r3
	mov	r3, #0
	orr	r4, r0, r2
	orr	r5, r1, r3
	ldr	r3, [fp, #-24]
	strd	r4, [r3]
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	beq	.L19
	ldr	r3, [fp, #-24]
	ldrd	r0, [r3]
	mov	r2, #0
	mov	r3, #0
	lsl	r3, r1, #8
	orr	r3, r3, r0, lsr #24
	lsl	r2, r0, #8
	ldr	r1, [fp, #-24]
	strd	r2, [r1]
.L19:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L18:
	ldr	r0, [fp, #-28]
	bl	strlen
	mov	r2, r0
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bhi	.L20
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	copyStr, .-copyStr
	.section	.rodata
	.align	2
.LC0:
	.ascii	"r\000"
	.align	2
.LC1:
	.ascii	"../../generator/inputs.txt\000"
	.align	2
.LC2:
	.ascii	"line: %s\000"
	.align	2
.LC3:
	.ascii	"encrypt time: %.7f\012\000"
	.align	2
.LC4:
	.ascii	"decrypt time: %.7f\012\000"
	.align	2
.LC5:
	.ascii	"Encrypted: %u\012\000"
	.align	2
.LC6:
	.ascii	"Decrypted: %u\012\000"
	.align	2
.LC7:
	.ascii	"[ERROR] : MMM did not decrypt successfully!\000"
	.align	2
.LC8:
	.ascii	"MMM decrypted successfully!\000"
	.align	2
.LC9:
	.ascii	"loop time: %.20f\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #144
	str	r0, [fp, #-128]
	str	r1, [fp, #-132]
	adr	r3, .L31
	ldrd	r2, [r3]
	strd	r2, [fp, #-12]
	adr	r3, .L31+8
	ldrd	r2, [r3]
	strd	r2, [fp, #-20]
	adr	r3, .L31+16
	ldrd	r2, [r3]
	strd	r2, [fp, #-28]
	adr	r3, .L31+24
	ldrd	r2, [r3]
	strd	r2, [fp, #-36]
	ldr	r1, .L31+40
	ldr	r0, .L31+44
	bl	fopen
	str	r0, [fp, #-40]
	bl	clock
	str	r0, [fp, #-44]
.L27:
	mov	r3, #0
	str	r3, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-52]
	mov	r3, #0
	str	r3, [fp, #-56]
	mov	r3, #0
	str	r3, [fp, #-60]
	sub	r3, fp, #124
	ldr	r2, [fp, #-40]
	mov	r1, #6
	mov	r0, r3
	bl	fgets
	mov	r3, r0
	cmp	r3, #0
	beq	.L30
	sub	r3, fp, #124
	mov	r1, r3
	ldr	r0, .L31+48
	bl	printf
	mov	r3, #0
	str	r3, [fp, #-80]
	sub	r3, fp, #124
	mov	r0, r3
	bl	atoi
	str	r0, [fp, #-80]
	mov	r2, #0
	mov	r3, #0
	strd	r2, [fp, #-92]
	ldr	r3, [fp, #-80]
	mov	r2, r3
	mov	r3, #0
	strd	r2, [fp, #-92]
	bl	clock
	str	r0, [fp, #-48]
	ldrd	r2, [fp, #-20]
	strd	r2, [sp, #8]
	ldrd	r2, [fp, #-12]
	strd	r2, [sp]
	ldrd	r2, [fp, #-28]
	ldrd	r0, [fp, #-92]
	bl	ME_MMM
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [fp, #-96]
	bl	clock
	str	r0, [fp, #-52]
	bl	clock
	str	r0, [fp, #-56]
	ldr	r3, [fp, #-96]
	mov	r0, r3
	mov	r1, #0
	ldrd	r2, [fp, #-20]
	strd	r2, [sp, #8]
	ldrd	r2, [fp, #-12]
	strd	r2, [sp]
	ldrd	r2, [fp, #-36]
	bl	ME_MMM
	mov	r2, r0
	mov	r3, r1
	mov	r3, r2
	str	r3, [fp, #-100]
	bl	clock
	str	r0, [fp, #-60]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-48]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L31+32
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-108]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L31+32
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-116]
	ldrd	r2, [fp, #-108]
	ldr	r0, .L31+52
	bl	printf
	ldrd	r2, [fp, #-116]
	ldr	r0, .L31+56
	bl	printf
	ldr	r1, [fp, #-96]
	ldr	r0, .L31+60
	bl	printf
	ldr	r1, [fp, #-100]
	ldr	r0, .L31+64
	bl	printf
	ldr	r3, [fp, #-100]
	mov	r2, r3
	mov	r3, #0
	ldrd	r0, [fp, #-92]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L24
	ldrd	r2, [fp, #-92]
	orrs	r3, r2, r3
	beq	.L24
	ldr	r3, [fp, #-96]
	cmp	r3, #0
	beq	.L24
	ldr	r3, [fp, #-100]
	cmp	r3, #0
	bne	.L25
.L24:
	ldr	r0, .L31+68
	bl	puts
	mov	r3, #1
	b	.L28
.L25:
	ldr	r0, .L31+72
	bl	puts
	b	.L27
.L30:
	nop
	bl	clock
	str	r0, [fp, #-64]
	ldr	r0, [fp, #-40]
	bl	fclose
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-44]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L31+32
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-76]
	ldrd	r2, [fp, #-76]
	ldr	r0, .L31+76
	bl	printf
	mov	r3, #1
.L28:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L32:
	.align	3
.L31:
	.word	2033264181
	.word	219791630
	.word	-870212449
	.word	13590870
	.word	2090913655
	.word	124668541
	.word	2135431367
	.word	188545989
	.word	0
	.word	1093567616
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
