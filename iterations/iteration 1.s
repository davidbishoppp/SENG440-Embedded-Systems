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
	.global	newUlli
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	newUlli, %function
newUlli:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	mov	r0, #16
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	add	r1, r3, #8
	ldr	r3, [fp, #-16]
	mov	r2, r3
	asr	r3, r2, #31
	strd	r2, [r1]
	ldr	r1, [fp, #-8]
	mov	r2, #0
	mov	r3, #0
	strd	r2, [r1]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	newUlli, .-newUlli
	.align	2
	.global	copyUlli
	.syntax unified
	.arm
	.fpu vfp
	.type	copyUlli, %function
copyUlli:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	mov	r0, #16
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	add	r1, r3, #8
	ldr	r3, [fp, #-16]
	ldrd	r2, [r3, #8]
	strd	r2, [r1]
	ldr	r3, [fp, #-16]
	ldrd	r2, [r3]
	ldr	r1, [fp, #-8]
	strd	r2, [r1]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	copyUlli, .-copyUlli
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%s: %llu %llu\012\000"
	.text
	.align	2
	.global	printUlli
	.syntax unified
	.arm
	.fpu vfp
	.type	printUlli, %function
printUlli:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, .L6
	ldr	ip, [r3]
	ldr	r3, [fp, #-8]
	ldrd	r2, [r3]
	ldr	r1, [fp, #-8]
	add	r1, r1, #8
	ldrd	r0, [r1]
	strd	r0, [sp, #8]
	strd	r2, [sp]
	ldr	r2, [fp, #-12]
	ldr	r1, .L6+4
	mov	r0, ip
	bl	fprintf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	2
.L6:
	.word	stderr
	.word	.LC0
	.size	printUlli, .-printUlli
	.align	2
	.syntax unified
	.arm
	.fpu vfp
	.type	zero, %function
zero:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L9
	ldr	r3, [fp, #-8]
	add	r3, r3, #8
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L9
	mov	r3, #1
	b	.L11
.L9:
	mov	r3, #0
.L11:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	zero, .-zero
	.align	2
	.global	shiftRight
	.syntax unified
	.arm
	.fpu vfp
	.type	shiftRight, %function
shiftRight:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-24]
	ldrd	r2, [r3]
	mov	r3, r2
	and	r3, r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-24]
	add	ip, r3, #8
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	strd	r2, [ip]
	ldr	r3, [fp, #-24]
	ldrd	r0, [r3]
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	ldr	r1, [fp, #-24]
	strd	r2, [r1]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L14
	ldr	r3, [fp, #-24]
	add	r3, r3, #8
	ldrd	r2, [r3]
	ldr	r1, [fp, #-24]
	add	ip, r1, #8
	mov	r0, #0
	mov	r1, #-2147483648
	orr	r4, r2, r0
	orr	r5, r3, r1
	strd	r4, [ip]
.L14:
	nop
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, r5, fp}
	bx	lr
	.size	shiftRight, .-shiftRight
	.align	2
	.global	shiftLeft
	.syntax unified
	.arm
	.fpu vfp
	.type	shiftLeft, %function
shiftLeft:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, r6, r7, r8, r9, fp}
	add	fp, sp, #24
	sub	sp, sp, #28
	str	r0, [fp, #-40]
	ldr	r1, [fp, #-40]
	add	r1, r1, #8
	ldrd	r0, [r1]
	mov	r6, #0
	mov	r7, #-2147483648
	and	r2, r0, r6
	and	r3, r1, r7
	strd	r2, [fp, #-36]
	ldr	r3, [fp, #-40]
	ldrd	r2, [r3]
	adds	r1, r2, r2
	str	r1, [fp, #-52]
	adc	r3, r3, r3
	str	r3, [fp, #-48]
	ldrd	r2, [fp, #-52]
	ldr	r1, [fp, #-40]
	strd	r2, [r1]
	ldr	r3, [fp, #-40]
	add	r3, r3, #8
	ldrd	r2, [r3]
	ldr	r1, [fp, #-40]
	add	r1, r1, #8
	adds	r8, r2, r2
	adc	r9, r3, r3
	mov	r2, r8
	mov	r3, r9
	strd	r2, [r1]
	ldrd	r2, [fp, #-36]
	orrs	r3, r2, r3
	beq	.L17
	ldr	r3, [fp, #-40]
	ldrd	r2, [r3]
	mov	r0, #1
	mov	r1, #0
	orr	r4, r2, r0
	orr	r5, r3, r1
	ldr	r3, [fp, #-40]
	strd	r4, [r3]
.L17:
	nop
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp}
	bx	lr
	.size	shiftLeft, .-shiftLeft
	.align	2
	.global	add
	.syntax unified
	.arm
	.fpu vfp
	.type	add, %function
add:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	push	{r4, r5, r6, r7, r8, r9, fp}
	add	fp, sp, #24
	sub	sp, sp, #36
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	mov	r3, #0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	beq	.L19
	ldr	r3, [fp, #-48]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mvn	ip, r2
	str	ip, [fp, #-60]
	mvn	r3, r3
	str	r3, [fp, #-56]
	ldrd	r2, [fp, #-60]
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L19
	mov	r3, #1
	str	r3, [fp, #-32]
.L19:
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-48]
	add	r3, r3, #8
	ldrd	r2, [r3]
	ldr	ip, [fp, #-40]
	add	ip, ip, #8
	adds	r8, r0, r2
	adc	r9, r1, r3
	strd	r8, [ip]
	ldr	r3, [fp, #-44]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-48]
	ldrd	r2, [r3]
	adds	r4, r0, r2
	adc	r5, r1, r3
	ldr	r3, [fp, #-32]
	mov	r2, r3
	asr	r3, r2, #31
	adds	r6, r4, r2
	adc	r7, r5, r3
	ldr	r3, [fp, #-40]
	strd	r6, [r3]
	nop
	sub	sp, fp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp}
	bx	lr
	.size	add, .-add
	.align	2
	.global	subtract
	.syntax unified
	.arm
	.fpu vfp
	.type	subtract, %function
subtract:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	add	fp, sp, #28
	sub	sp, sp, #24
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	ldr	r0, [fp, #-44]
	bl	copyUlli
	str	r0, [fp, #-32]
	ldr	r0, [fp, #-48]
	bl	copyUlli
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-32]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-36]
	add	r3, r3, #8
	ldrd	r2, [r3]
	ldr	ip, [fp, #-40]
	add	ip, ip, #8
	subs	r8, r0, r2
	sbc	r9, r1, r3
	strd	r8, [ip]
	ldr	r3, [fp, #-32]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-36]
	ldrd	r2, [r3]
	subs	r4, r0, r2
	sbc	r5, r1, r3
	ldr	r3, [fp, #-40]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-32]
	add	r3, r3, #8
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	movhi	r3, #1
	movls	r3, #0
	uxtb	r3, r3
	uxtb	r2, r3
	mov	r3, #0
	subs	r6, r4, r2
	sbc	r7, r5, r3
	ldr	r3, [fp, #-40]
	strd	r6, [r3]
	ldr	r0, [fp, #-32]
	bl	free
	ldr	r0, [fp, #-36]
	bl	free
	nop
	sub	sp, fp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
	.size	subtract, .-subtract
	.align	2
	.global	bitLength
	.syntax unified
	.arm
	.fpu vfp
	.type	bitLength, %function
bitLength:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-24]
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	beq	.L22
	ldr	r3, [fp, #-24]
	ldrd	r2, [r3]
	strd	r2, [fp, #-20]
	mov	r3, #64
	str	r3, [fp, #-8]
	b	.L24
.L22:
	ldr	r3, [fp, #-24]
	ldrd	r2, [r3, #8]
	strd	r2, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L24
.L25:
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
	ldrd	r0, [fp, #-20]
	mov	r2, #0
	mov	r3, #0
	lsr	r2, r0, #1
	orr	r2, r2, r1, lsl #31
	lsr	r3, r1, #1
	strd	r2, [fp, #-20]
.L24:
	ldrd	r2, [fp, #-20]
	orrs	r3, r2, r3
	bne	.L25
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	bitLength, .-bitLength
	.align	2
	.global	equal
	.syntax unified
	.arm
	.fpu vfp
	.type	equal, %function
equal:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-12]
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L28
	ldr	r3, [fp, #-8]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #8
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L28
	mov	r3, #1
	b	.L29
.L28:
	mov	r3, #0
.L29:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	equal, .-equal
	.align	2
	.global	greaterThan
	.syntax unified
	.arm
	.fpu vfp
	.type	greaterThan, %function
greaterThan:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-12]
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L31
	mov	r3, #1
	b	.L32
.L31:
	ldr	r3, [fp, #-8]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-12]
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bne	.L33
	ldr	r3, [fp, #-8]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-12]
	add	r3, r3, #8
	ldrd	r2, [r3]
	cmp	r1, r3
	cmpeq	r0, r2
	bls	.L33
	mov	r3, #1
	b	.L32
.L33:
	mov	r3, #0
.L32:
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	greaterThan, .-greaterThan
	.align	2
	.global	copyStr
	.syntax unified
	.arm
	.fpu vfp
	.type	copyStr, %function
copyStr:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #24
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	ldr	r0, [fp, #-36]
	bl	strlen
	mov	r3, r0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L35
.L39:
	ldr	r3, [fp, #-32]
	add	r3, r3, #8
	ldrd	r0, [r3]
	ldr	r3, [fp, #-16]
	ldr	r2, [fp, #-36]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	uxtb	r2, r3
	mov	r3, #0
	ldr	ip, [fp, #-32]
	add	ip, ip, #8
	orr	r4, r0, r2
	orr	r5, r1, r3
	strd	r4, [ip]
	ldr	r3, [fp, #-24]
	sub	r3, r3, #1
	ldr	r2, [fp, #-16]
	cmp	r2, r3
	beq	.L36
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L37
.L38:
	ldr	r0, [fp, #-32]
	bl	shiftLeft
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L37:
	ldr	r3, [fp, #-20]
	cmp	r3, #7
	ble	.L38
.L36:
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L35:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-24]
	cmp	r2, r3
	blt	.L39
	nop
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	copyStr, .-copyStr
	.global	M
	.data
	.align	3
	.type	M, %object
	.size	M, 16
M:
	.word	0
	.word	0
	.word	2033264181
	.word	219791630
	.global	R2
	.align	3
	.type	R2, %object
	.size	R2, 16
R2:
	.word	0
	.word	0
	.word	-870212449
	.word	13590870
	.global	E
	.align	3
	.type	E, %object
	.size	E, 16
E:
	.word	0
	.word	0
	.word	2090913655
	.word	124668541
	.global	D
	.align	3
	.type	D, %object
	.size	D, 16
D:
	.word	0
	.word	0
	.word	2135431367
	.word	188545989
	.text
	.align	2
	.global	newR
	.syntax unified
	.arm
	.fpu vfp
	.type	newR, %function
newR:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, fp, lr}
	add	fp, sp, #20
	sub	sp, sp, #16
	str	r0, [fp, #-32]
	mov	r0, #0
	bl	newUlli
	str	r0, [fp, #-24]
	ldr	r3, [fp, #-32]
	cmp	r3, #0
	beq	.L41
	ldr	r3, [fp, #-32]
	cmp	r3, #128
	ble	.L42
.L41:
	ldr	r3, [fp, #-24]
	b	.L43
.L42:
	ldr	r3, [fp, #-32]
	cmp	r3, #64
	ble	.L44
	ldr	r3, [fp, #-24]
	ldrd	r0, [r3]
	ldr	r3, [fp, #-32]
	sub	r3, r3, #64
	mov	r2, #1
	lsl	r3, r2, r3
	mov	r2, r3
	asr	r3, r2, #31
	orr	r6, r0, r2
	orr	r7, r1, r3
	ldr	r3, [fp, #-24]
	strd	r6, [r3]
	b	.L45
.L44:
	ldr	r3, [fp, #-24]
	add	r3, r3, #8
	ldrd	r0, [r3]
	mov	r2, #1
	ldr	r3, [fp, #-32]
	lsl	r3, r2, r3
	mov	r2, r3
	asr	r3, r2, #31
	ldr	ip, [fp, #-24]
	add	ip, ip, #8
	orr	r4, r0, r2
	orr	r5, r1, r3
	strd	r4, [ip]
.L45:
	ldr	r3, [fp, #-24]
.L43:
	mov	r0, r3
	sub	sp, fp, #20
	@ sp needed
	pop	{r4, r5, r6, r7, fp, pc}
	.size	newR, .-newR
	.align	2
	.global	MMM
	.syntax unified
	.arm
	.fpu vfp
	.type	MMM, %function
MMM:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #32
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	mov	r0, #0
	bl	newUlli
	str	r0, [fp, #-20]
	ldr	r0, [fp, #-40]
	bl	copyUlli
	str	r0, [fp, #-24]
	ldr	r0, .L53
	bl	copyUlli
	str	r0, [fp, #-28]
	ldr	r0, [fp, #-28]
	bl	bitLength
	str	r0, [fp, #-32]
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L47
.L50:
	ldr	r3, [fp, #-20]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mov	r1, r2
	ldr	r3, [fp, #-24]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mov	r0, r2
	ldr	r3, [fp, #-44]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mov	r3, r2
	and	r3, r3, r0
	eor	r3, r3, r1
	and	r3, r3, #1
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L48
	ldr	r2, [fp, #-20]
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-20]
	bl	add
.L48:
	ldr	r3, [fp, #-24]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mov	r0, #1
	mov	r1, #0
	and	r4, r2, r0
	and	r5, r3, r1
	orrs	r3, r4, r5
	beq	.L49
	ldr	r2, [fp, #-20]
	ldr	r1, [fp, #-44]
	ldr	r0, [fp, #-20]
	bl	add
.L49:
	ldr	r0, [fp, #-24]
	bl	shiftRight
	ldr	r0, [fp, #-20]
	bl	shiftRight
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L47:
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-32]
	cmp	r2, r3
	blt	.L50
	ldr	r1, [fp, #-28]
	ldr	r0, [fp, #-20]
	bl	greaterThan
	mov	r3, r0
	cmp	r3, #0
	beq	.L51
	ldr	r2, [fp, #-28]
	ldr	r1, [fp, #-20]
	ldr	r0, [fp, #-20]
	bl	subtract
.L51:
	ldr	r0, [fp, #-24]
	bl	free
	ldr	r0, [fp, #-28]
	bl	free
	ldr	r3, [fp, #-20]
	mov	r0, r3
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
.L54:
	.align	2
.L53:
	.word	M
	.size	MMM, .-MMM
	.align	2
	.global	MMM_without_scale
	.syntax unified
	.arm
	.fpu vfp
	.type	MMM_without_scale, %function
MMM_without_scale:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-32]
	str	r1, [fp, #-36]
	mov	r0, #1
	bl	newUlli
	str	r0, [fp, #-8]
	ldr	r0, .L57
	bl	copyUlli
	str	r0, [fp, #-12]
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-32]
	bl	MMM
	str	r0, [fp, #-16]
	ldr	r1, [fp, #-12]
	ldr	r0, [fp, #-36]
	bl	MMM
	str	r0, [fp, #-20]
	ldr	r1, [fp, #-20]
	ldr	r0, [fp, #-16]
	bl	MMM
	str	r0, [fp, #-24]
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-24]
	bl	MMM
	str	r0, [fp, #-28]
	ldr	r0, [fp, #-8]
	bl	free
	ldr	r0, [fp, #-12]
	bl	free
	ldr	r0, [fp, #-16]
	bl	free
	ldr	r0, [fp, #-20]
	bl	free
	ldr	r0, [fp, #-24]
	bl	free
	ldr	r3, [fp, #-28]
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L58:
	.align	2
.L57:
	.word	R2
	.size	MMM_without_scale, .-MMM_without_scale
	.align	2
	.global	ME_MMM
	.syntax unified
	.arm
	.fpu vfp
	.type	ME_MMM, %function
ME_MMM:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #16
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov	r0, #1
	bl	newUlli
	str	r0, [fp, #-16]
	b	.L60
.L62:
	ldr	r3, [fp, #-28]
	add	r3, r3, #8
	ldrd	r2, [r3]
	mov	r0, #1
	mov	r1, #0
	and	r4, r2, r0
	and	r5, r3, r1
	orrs	r3, r4, r5
	beq	.L61
	ldr	r1, [fp, #-16]
	ldr	r0, [fp, #-24]
	bl	MMM_without_scale
	str	r0, [fp, #-16]
.L61:
	ldr	r1, [fp, #-24]
	ldr	r0, [fp, #-24]
	bl	MMM_without_scale
	str	r0, [fp, #-24]
	ldr	r0, [fp, #-28]
	bl	shiftRight
.L60:
	ldr	r3, [fp, #-28]
	add	r3, r3, #8
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L62
	ldr	r3, [fp, #-28]
	ldrd	r2, [r3]
	orrs	r3, r2, r3
	bne	.L62
	ldr	r3, [fp, #-16]
	mov	r0, r3
	sub	sp, fp, #12
	@ sp needed
	pop	{r4, r5, fp, pc}
	.size	ME_MMM, .-ME_MMM
	.align	2
	.global	Encypt
	.syntax unified
	.arm
	.fpu vfp
	.type	Encypt, %function
Encypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r0, .L66
	bl	copyUlli
	str	r0, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-16]
	bl	ME_MMM
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L67:
	.align	2
.L66:
	.word	E
	.size	Encypt, .-Encypt
	.align	2
	.global	Decrypt
	.syntax unified
	.arm
	.fpu vfp
	.type	Decrypt, %function
Decrypt:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r0, .L70
	bl	copyUlli
	str	r0, [fp, #-8]
	ldr	r1, [fp, #-8]
	ldr	r0, [fp, #-16]
	bl	ME_MMM
	mov	r3, r0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L71:
	.align	2
.L70:
	.word	D
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
	.ascii	"MMM DID NOT encrypt successfully!\000"
	.align	2
.LC8:
	.ascii	"loop time: %.20f\012\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 104
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #112
	str	r0, [fp, #-104]
	str	r1, [fp, #-108]
	ldr	r1, .L82+8
	ldr	r0, .L82+12
	bl	fopen
	str	r0, [fp, #-8]
	ldr	r1, .L82+16
	ldr	r0, .L82+20
	bl	fopen
	str	r0, [fp, #-12]
	ldr	r3, [fp, #-12]
	mov	r2, #16
	mov	r1, #1
	ldr	r0, .L82+24
	bl	fwrite
	bl	clock
	str	r0, [fp, #-16]
.L78:
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-32]
	sub	r3, fp, #96
	ldr	r2, [fp, #-8]
	mov	r1, #11
	mov	r0, r3
	bl	fgets
	mov	r3, r0
	cmp	r3, #0
	beq	.L81
	mov	r2, #0
	mov	r3, #0
	strd	r2, [fp, #-76]
	mov	r2, #0
	mov	r3, #0
	strd	r2, [fp, #-84]
	sub	r2, fp, #96
	sub	r3, fp, #84
	mov	r1, r2
	mov	r0, r3
	bl	copyStr
	bl	clock
	str	r0, [fp, #-20]
	sub	r3, fp, #84
	mov	r0, r3
	bl	Encypt
	str	r0, [fp, #-48]
	bl	clock
	str	r0, [fp, #-24]
	bl	clock
	str	r0, [fp, #-28]
	ldr	r0, [fp, #-48]
	bl	Decrypt
	str	r0, [fp, #-52]
	bl	clock
	str	r0, [fp, #-32]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-20]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L82
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-60]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-28]
	sub	r3, r2, r3
	vmov	s15, r3	@ int
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L82
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-68]
	ldrd	r2, [fp, #-68]
	strd	r2, [sp]
	ldrd	r2, [fp, #-60]
	ldr	r1, .L82+28
	ldr	r0, [fp, #-12]
	bl	fprintf
	sub	r3, fp, #84
	ldr	r1, [fp, #-52]
	mov	r0, r3
	bl	equal
	mov	r3, r0
	cmp	r3, #0
	beq	.L75
	sub	r3, fp, #84
	mov	r0, r3
	bl	zero
	mov	r3, r0
	cmp	r3, #0
	bne	.L75
	ldr	r0, [fp, #-48]
	bl	zero
	mov	r3, r0
	cmp	r3, #0
	bne	.L75
	ldr	r0, [fp, #-52]
	bl	zero
	mov	r3, r0
	cmp	r3, #0
	beq	.L76
.L75:
	ldr	r0, .L82+32
	bl	puts
	ldr	r0, [fp, #-48]
	bl	free
	ldr	r0, [fp, #-52]
	bl	free
	mov	r3, #1
	b	.L79
.L76:
	ldr	r0, [fp, #-48]
	bl	free
	ldr	r0, [fp, #-52]
	bl	free
	b	.L78
.L81:
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
	vcvt.f64.s32	d6, s15
	vldr.64	d5, .L82
	vdiv.f64	d7, d6, d5
	vstr.64	d7, [fp, #-44]
	ldrd	r2, [fp, #-44]
	ldr	r0, .L82+36
	bl	printf
	mov	r3, #1
.L79:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L83:
	.align	3
.L82:
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
