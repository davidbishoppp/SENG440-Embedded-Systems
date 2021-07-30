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
	.arch armv6
	.syntax unified
	.arm
	.fpu neon
	.type	and_low, %function
and_low:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #36
	vstr	d0, [fp, #-36]
	vstr	d1, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vmov	r2, r3, d16	@ int
	mov	r3, r2
	and	r3, r3, #1
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	and_low, .-and_low
	.align	2
	.syntax unified
	.arm
	.fpu neon
	.type	newU128, %function
newU128:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #44
	strd	r0, [fp, #-36]
	strd	r2, [fp, #-44]
	sub	r3, fp, #28
	mov	r1, r3
	ldrd	r2, [fp, #-44]
	strd	r2, [r1]
	sub	r3, fp, #28
	mov	r1, r3
	ldrd	r2, [fp, #-36]
	strd	r2, [r1, #8]
	sub	r3, fp, #28
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	vld1.64	{d16-d17}, [r3:64]
	vmov	q0, q8  @ v2di
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	newU128, .-newU128
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%s - low: 0x%llx high: 0x%llx\012\000"
	.text
	.align	2
	.global	printU128
	.syntax unified
	.arm
	.fpu neon
	.type	printU128, %function
printU128:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #72
	vstr	d0, [fp, #-52]
	vstr	d1, [fp, #-44]
	str	r0, [fp, #-56]
	ldr	r3, .L10
	ldr	ip, [r3]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vmov	r2, r3, d16	@ int
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vmov	r0, r1, d17	@ int
	strd	r0, [sp, #8]
	strd	r2, [sp]
	ldr	r2, [fp, #-56]
	ldr	r1, .L10+4
	mov	r0, ip
	bl	fprintf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L11:
	.align	2
.L10:
	.word	stderr
	.word	.LC0
	.size	printU128, .-printU128
	.align	2
	.global	shiftRight
	.syntax unified
	.arm
	.fpu neon
	.type	shiftRight, %function
shiftRight:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #60
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	mov	r3, #0
	str	r3, [fp, #-16]
	ldrd	r4, [fp, #-60]
	mov	r0, #1
	mov	r1, #0
	and	r2, r4, r0
	and	r3, r5, r1
	orrs	r3, r2, r3
	beq	.L13
	mov	r3, #1
	str	r3, [fp, #-16]
.L13:
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vshr.u64	q8, q8, #1
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L15
	ldrd	r4, [fp, #-52]
	mov	r0, #0
	mov	r1, #-2147483648
	orr	r2, r4, r0
	orr	r3, r5, r1
	strd	r2, [fp, #-52]
.L15:
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov	q0, q8  @ v2di
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, r5, fp}
	bx	lr
	.size	shiftRight, .-shiftRight
	.align	2
	.global	shiftLeft
	.syntax unified
	.arm
	.fpu neon
	.type	shiftLeft, %function
shiftLeft:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #60
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	mov	r3, #0
	str	r3, [fp, #-16]
	ldrd	r2, [fp, #-68]
	cmp	r2, #0
	sbcs	r3, r3, #0
	bge	.L18
	mov	r3, #1
	str	r3, [fp, #-16]
.L18:
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vshl.i64	q8, q8, #1
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L20
	ldrd	r4, [fp, #-44]
	mov	r0, #1
	mov	r1, #0
	orr	r2, r4, r0
	orr	r3, r5, r1
	strd	r2, [fp, #-44]
.L20:
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov	q0, q8  @ v2di
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, r5, fp}
	bx	lr
	.size	shiftLeft, .-shiftLeft
	.align	2
	.global	add
	.syntax unified
	.arm
	.fpu neon
	.type	add, %function
add:
	@ args = 0, pretend = 0, frame = 96
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #100
	vstr	d0, [fp, #-84]
	vstr	d1, [fp, #-76]
	vstr	d2, [fp, #-100]
	vstr	d3, [fp, #-92]
	ldrd	r2, [fp, #-100]
	strd	r2, [fp, #-12]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vldr	d18, [fp, #-84]
	vldr	d19, [fp, #-76]
	vstr	d18, [fp, #-36]
	vstr	d19, [fp, #-28]
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	vldr	d18, [fp, #-36]
	vldr	d19, [fp, #-28]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vadd.i64	q8, q9, q8
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	ldrd	r2, [fp, #-68]
	strd	r2, [fp, #-20]
	ldrd	r0, [fp, #-20]
	ldrd	r2, [fp, #-12]
	cmp	r1, r3
	cmpeq	r0, r2
	bcs	.L24
	ldrd	r0, [fp, #-60]
	adds	r2, r0, #1
	adc	r3, r1, #0
	strd	r2, [fp, #-60]
.L24:
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vmov	q0, q8  @ v2di
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	add, .-add
	.align	2
	.global	subtract
	.syntax unified
	.arm
	.fpu neon
	.type	subtract, %function
subtract:
	@ args = 0, pretend = 0, frame = 168
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #172
	vstr	d0, [fp, #-156]
	vstr	d1, [fp, #-148]
	vstr	d2, [fp, #-172]
	vstr	d3, [fp, #-164]
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	vldr	d16, [fp, #-172]
	vldr	d17, [fp, #-164]
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d18, [fp, #-84]
	vldr	d19, [fp, #-76]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vsub.i64	q8, q9, q8
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	sub	r3, fp, #124
	str	r3, [fp, #-48]
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	ldr	r3, [fp, #-48]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #140
	str	r3, [fp, #-24]
	vldr	d16, [fp, #-156]
	vldr	d17, [fp, #-148]
	vstr	d16, [fp, #-44]
	vstr	d17, [fp, #-36]
	vldr	d16, [fp, #-44]
	vldr	d17, [fp, #-36]
	ldr	r3, [fp, #-24]
	vst1.64	{d16-d17}, [r3:64]
	sub	r3, fp, #124
	ldrd	r0, [r3]
	sub	r3, fp, #140
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L28
	sub	r3, fp, #124
	ldrd	r0, [r3, #8]
	subs	r2, r0, #1
	sbc	r3, r1, #0
	sub	r1, fp, #124
	strd	r2, [r1, #8]
	sub	r3, fp, #124
	str	r3, [fp, #-104]
	ldr	r3, [fp, #-104]
	vld1.64	{d16-d17}, [r3:64]
	b	.L31
.L28:
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
.L31:
	vmov	q0, q8  @ v2di
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	subtract, .-subtract
	.align	2
	.global	greaterThanEqual
	.syntax unified
	.arm
	.fpu neon
	.type	greaterThanEqual, %function
greaterThanEqual:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #132
	vstr	d0, [fp, #-116]
	vstr	d1, [fp, #-108]
	vstr	d2, [fp, #-132]
	vstr	d3, [fp, #-124]
	vldr	d16, [fp, #-116]
	vldr	d17, [fp, #-108]
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vmov	r2, r3, d16	@ int
	strd	r2, [fp, #-12]
	vldr	d16, [fp, #-116]
	vldr	d17, [fp, #-108]
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vmov	r2, r3, d17	@ int
	strd	r2, [fp, #-20]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vmov	r2, r3, d16	@ int
	strd	r2, [fp, #-28]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov	r2, r3, d17	@ int
	strd	r2, [fp, #-36]
	ldrd	r0, [fp, #-20]
	ldrd	r2, [fp, #-36]
	cmp	r1, r3
	cmpeq	r0, r2
	bhi	.L37
	ldrd	r0, [fp, #-20]
	ldrd	r2, [fp, #-36]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L38
	ldrd	r0, [fp, #-12]
	ldrd	r2, [fp, #-28]
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L38
.L37:
	mov	r3, #1
	b	.L39
.L38:
	mov	r3, #0
.L39:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	greaterThanEqual, .-greaterThanEqual
	.align	2
	.global	equal
	.syntax unified
	.arm
	.fpu neon
	.type	equal, %function
equal:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #132
	vstr	d0, [fp, #-116]
	vstr	d1, [fp, #-108]
	vstr	d2, [fp, #-132]
	vstr	d3, [fp, #-124]
	vldr	d16, [fp, #-116]
	vldr	d17, [fp, #-108]
	vstr	d16, [fp, #-100]
	vstr	d17, [fp, #-92]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vmov	r2, r3, d16	@ int
	strd	r2, [fp, #-12]
	vldr	d16, [fp, #-116]
	vldr	d17, [fp, #-108]
	vstr	d16, [fp, #-84]
	vstr	d17, [fp, #-76]
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vmov	r2, r3, d17	@ int
	strd	r2, [fp, #-20]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vstr	d16, [fp, #-68]
	vstr	d17, [fp, #-60]
	vldr	d16, [fp, #-68]
	vldr	d17, [fp, #-60]
	vmov	r2, r3, d16	@ int
	strd	r2, [fp, #-28]
	vldr	d16, [fp, #-132]
	vldr	d17, [fp, #-124]
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov	r2, r3, d17	@ int
	strd	r2, [fp, #-36]
	ldrd	r0, [fp, #-20]
	ldrd	r2, [fp, #-36]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L45
	ldrd	r0, [fp, #-12]
	ldrd	r2, [fp, #-28]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L45
	mov	r3, #1
	b	.L46
.L45:
	mov	r3, #0
.L46:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	equal, .-equal
	.align	2
	.global	copyStr
	.syntax unified
	.arm
	.fpu neon
	.type	copyStr, %function
copyStr:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	atoll
	mov	r2, r0
	mov	r3, r1
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vmov	q8, q0  @ v2di
	vmov	q0, q8  @ v2di
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	copyStr, .-copyStr
	.align	2
	.global	MMM
	.syntax unified
	.arm
	.fpu neon
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, fp, lr}
	vpush.64	{d8, d9, d10, d11}
	add	fp, sp, #48
	sub	sp, sp, #36
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	vstr	d2, [fp, #-84]
	vstr	d3, [fp, #-76]
	adr	r3, .L56
	ldrd	r2, [r3]
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vmov	q5, q0  @ v2di
	mov	r2, #0
	mov	r3, #0
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vmov	q4, q0  @ v2di
	vldr	d0, [fp, #-84]
	vldr	d1, [fp, #-76]
	bl	and_low
	mov	r3, r0
	mov	r6, r3
	mov	r4, #0
	b	.L50
.L53:
	vmov	q0, q4  @ v2di
	bl	and_low
	mov	r5, r0
	vldr	d0, [fp, #-68]
	vldr	d1, [fp, #-60]
	bl	and_low
	mov	r2, r0
	mov	r3, r6
	and	r3, r3, r2
	eor	r3, r3, r5
	mov	r5, r3
	cmp	r5, #0
	beq	.L51
	vmov	q1, q5  @ v2di
	vmov	q0, q4  @ v2di
	bl	add
	vmov	q4, q0  @ v2di
.L51:
	vldr	d0, [fp, #-68]
	vldr	d1, [fp, #-60]
	bl	and_low
	mov	r3, r0
	cmp	r3, #0
	beq	.L52
	vldr	d2, [fp, #-84]
	vldr	d3, [fp, #-76]
	vmov	q0, q4  @ v2di
	bl	add
	vmov	q4, q0  @ v2di
.L52:
	vldr	d0, [fp, #-68]
	vldr	d1, [fp, #-60]
	bl	shiftRight
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	vmov	q0, q4  @ v2di
	bl	shiftRight
	vmov	q4, q0  @ v2di
	add	r4, r4, #1
.L50:
	cmp	r4, #59
	ble	.L53
	vmov	q1, q5  @ v2di
	vmov	q0, q4  @ v2di
	bl	greaterThanEqual
	mov	r3, r0
	cmp	r3, #0
	beq	.L54
	vmov	q1, q5  @ v2di
	vmov	q0, q4  @ v2di
	bl	subtract
	vmov	q4, q0  @ v2di
.L54:
	vmov	q8, q4  @ v2di
	vmov	q0, q8  @ v2di
	sub	sp, fp, #48
	@ sp needed
	vldm	sp!, {d8-d11}
	pop	{r4, r5, r6, fp, pc}
.L57:
	.align	3
.L56:
	.word	2033264181
	.word	219791630
	.size	MMM, .-MMM
	.align	2
	.global	MMM_without_scale
	.syntax unified
	.arm
	.fpu neon
	.type	MMM_without_scale, %function
MMM_without_scale:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #128
	vstr	d0, [fp, #-116]
	vstr	d1, [fp, #-108]
	vstr	d2, [fp, #-132]
	vstr	d3, [fp, #-124]
	mov	r2, #1
	mov	r3, #0
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vstr	d0, [fp, #-20]
	vstr	d1, [fp, #-12]
	adr	r3, .L60
	ldrd	r2, [r3]
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vstr	d0, [fp, #-36]
	vstr	d1, [fp, #-28]
	vldr	d2, [fp, #-36]
	vldr	d3, [fp, #-28]
	vldr	d0, [fp, #-116]
	vldr	d1, [fp, #-108]
	bl	MMM
	vstr	d0, [fp, #-52]
	vstr	d1, [fp, #-44]
	vldr	d2, [fp, #-36]
	vldr	d3, [fp, #-28]
	vldr	d0, [fp, #-132]
	vldr	d1, [fp, #-124]
	bl	MMM
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	vldr	d2, [fp, #-68]
	vldr	d3, [fp, #-60]
	vldr	d0, [fp, #-52]
	vldr	d1, [fp, #-44]
	bl	MMM
	vstr	d0, [fp, #-84]
	vstr	d1, [fp, #-76]
	vldr	d2, [fp, #-20]
	vldr	d3, [fp, #-12]
	vldr	d0, [fp, #-84]
	vldr	d1, [fp, #-76]
	bl	MMM
	vstr	d0, [fp, #-100]
	vstr	d1, [fp, #-92]
	vldr	d16, [fp, #-100]
	vldr	d17, [fp, #-92]
	vmov	q0, q8  @ v2di
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L61:
	.align	3
.L60:
	.word	-870212449
	.word	13590870
	.size	MMM_without_scale, .-MMM_without_scale
	.align	2
	.global	ME_MMM
	.syntax unified
	.arm
	.fpu neon
	.type	ME_MMM, %function
ME_MMM:
	@ args = 0, pretend = 0, frame = 80
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #80
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	vstr	d2, [fp, #-84]
	vstr	d3, [fp, #-76]
	mov	r2, #1
	mov	r3, #0
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vstr	d0, [fp, #-20]
	vstr	d1, [fp, #-12]
	b	.L63
.L66:
	vldr	d0, [fp, #-84]
	vldr	d1, [fp, #-76]
	bl	and_low
	mov	r3, r0
	cmp	r3, #0
	beq	.L64
	vldr	d2, [fp, #-20]
	vldr	d3, [fp, #-12]
	vldr	d0, [fp, #-68]
	vldr	d1, [fp, #-60]
	bl	MMM_without_scale
	vstr	d0, [fp, #-20]
	vstr	d1, [fp, #-12]
.L64:
	vldr	d2, [fp, #-68]
	vldr	d3, [fp, #-60]
	vldr	d0, [fp, #-68]
	vldr	d1, [fp, #-60]
	bl	MMM_without_scale
	vstr	d0, [fp, #-68]
	vstr	d1, [fp, #-60]
	vldr	d0, [fp, #-84]
	vldr	d1, [fp, #-76]
	bl	shiftRight
	vstr	d0, [fp, #-84]
	vstr	d1, [fp, #-76]
.L63:
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vstr	d16, [fp, #-36]
	vstr	d17, [fp, #-28]
	vldr	d16, [fp, #-36]
	vldr	d17, [fp, #-28]
	vmov	r2, r3, d16	@ int
	orrs	r3, r2, r3
	bne	.L66
	vldr	d16, [fp, #-84]
	vldr	d17, [fp, #-76]
	vstr	d16, [fp, #-52]
	vstr	d17, [fp, #-44]
	vldr	d16, [fp, #-52]
	vldr	d17, [fp, #-44]
	vmov	r2, r3, d17	@ int
	orrs	r3, r2, r3
	bne	.L66
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vmov	q0, q8  @ v2di
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	ME_MMM, .-ME_MMM
	.align	2
	.global	Encypt
	.syntax unified
	.arm
	.fpu neon
	.type	Encypt, %function
Encypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	vstr	d0, [fp, #-20]
	vstr	d1, [fp, #-12]
	adr	r3, .L71
	ldrd	r2, [r3]
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vmov	q8, q0  @ v2di
	vmov	q1, q8  @ v2di
	vldr	d0, [fp, #-20]
	vldr	d1, [fp, #-12]
	bl	ME_MMM
	vmov	q8, q0  @ v2di
	vmov	q0, q8  @ v2di
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L72:
	.align	3
.L71:
	.word	2090913655
	.word	124668541
	.size	Encypt, .-Encypt
	.align	2
	.global	Decrypt
	.syntax unified
	.arm
	.fpu neon
	.type	Decrypt, %function
Decrypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	vstr	d0, [fp, #-20]
	vstr	d1, [fp, #-12]
	adr	r3, .L75
	ldrd	r2, [r3]
	mov	r0, #0
	mov	r1, #0
	bl	newU128
	vmov	q8, q0  @ v2di
	vmov	q1, q8  @ v2di
	vldr	d0, [fp, #-20]
	vldr	d1, [fp, #-12]
	bl	ME_MMM
	vmov	q8, q0  @ v2di
	vmov	q0, q8  @ v2di
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L76:
	.align	3
.L75:
	.word	2135431367
	.word	188545989
	.size	Decrypt, .-Decrypt
	.section	.rodata
	.align	2
.LC1:
	.ascii	"r\000"
	.align	2
.LC2:
	.ascii	"./generator/inputs.txt\000"
	.align	2
.LC3:
	.ascii	"w+\000"
	.align	2
.LC4:
	.ascii	"./results/results.csv\000"
	.align	2
.LC5:
	.ascii	"encrypt,decrypt\012\000"
	.align	2
.LC6:
	.ascii	"%.7f,%.7f\012\000"
	.align	2
.LC7:
	.ascii	"NOT euqal!\000"
	.align	2
.LC8:
	.ascii	"loop time: %.20f\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #136
	str	r0, [fp, #-128]
	str	r1, [fp, #-132]
	ldr	r1, .L86+8
	ldr	r0, .L86+12
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r1, .L86+16
	ldr	r0, .L86+20
	bl	fopen
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	mov	r2, #16
	mov	r1, #1
	ldr	r0, .L86+24
	bl	fwrite
	bl	clock
	str	r0, [fp, #-16]
.L82:
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-32]
	sub	r3, fp, #120
	ldr	r2, [fp, #-8]
	mov	r1, #11
	mov	r0, r3
	bl	fgets
	mov	r3, r0
	cmp	r3, #0
	beq	.L85
	sub	r3, fp, #120
	mov	r0, r3
	bl	copyStr
	vstr	d0, [fp, #-60]
	vstr	d1, [fp, #-52]
	bl	clock
	str	r0, [fp, #-20]
	vldr	d0, [fp, #-60]
	vldr	d1, [fp, #-52]
	bl	Encypt
	vstr	d0, [fp, #-76]
	vstr	d1, [fp, #-68]
	bl	clock
	str	r0, [fp, #-24]
	bl	clock
	str	r0, [fp, #-28]
	vldr	d0, [fp, #-76]
	vldr	d1, [fp, #-68]
	bl	Decrypt
	vstr	d0, [fp, #-92]
	vstr	d1, [fp, #-84]
	bl	clock
	str	r0, [fp, #-32]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vldr.64	d18, .L86
	vdiv.f64	d16, d17, d18
	vstr.64	d16, [fp, #-100]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-28]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vldr.64	d18, .L86
	vdiv.f64	d16, d17, d18
	vstr.64	d16, [fp, #-108]
	ldrd	r2, [fp, #-108]
	strd	r2, [sp]
	ldrd	r2, [fp, #-100]
	ldr	r1, .L86+28
	ldr	r0, [fp, #-12]
	bl	fprintf
	vldr	d2, [fp, #-92]
	vldr	d3, [fp, #-84]
	vldr	d0, [fp, #-60]
	vldr	d1, [fp, #-52]
	bl	equal
	mov	r3, r0
	cmp	r3, #0
	bne	.L82
	ldr	r0, .L86+32
	bl	printf
	mov	r3, #1
	b	.L83
.L85:
	nop
	bl	clock
	str	r0, [fp, #-36]
	ldr	r0, [fp, #-8]
	bl	fclose
	ldr	r0, [fp, #-12]
	bl	fclose
	ldr	r2, [fp, #-36]
	ldr	r3, [fp, #-16]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d17, s15
	vldr.64	d18, .L86
	vdiv.f64	d16, d17, d18
	vstr.64	d16, [fp, #-44]
	ldrd	r2, [fp, #-44]
	ldr	r0, .L86+36
	bl	printf
	mov	r3, #1
.L83:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L87:
	.align	3
.L86:
	.word	0
	.word	1093567616
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
