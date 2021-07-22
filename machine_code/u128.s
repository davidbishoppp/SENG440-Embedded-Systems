	.arch armv7-a
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
	.file	"u128.c"
	.text
	.align	2
	.global	add
	.arch armv7-a
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	add, %function
add:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	ip, [r2]
	ldr	r3, [r1]
	.syntax divided
@ 15 "u128.c" 1
	adds r3, r3, ip;
@ 0 "" 2
	.arm
	.syntax unified
	str	r3, [r0]
	ldr	ip, [r2, #4]
	ldr	r3, [r1, #4]
	.syntax divided
@ 16 "u128.c" 1
	adc r3, r3, ip;
@ 0 "" 2
	.arm
	.syntax unified
	str	r3, [r0, #4]
	ldr	ip, [r2, #8]
	ldr	r3, [r1, #8]
	.syntax divided
@ 17 "u128.c" 1
	adc r3, r3, ip;
@ 0 "" 2
	.arm
	.syntax unified
	str	r3, [r0, #8]
	ldr	r3, [r1, #12]
	ldr	r2, [r2, #12]
	.syntax divided
@ 18 "u128.c" 1
	adc r3, r3, r2;
@ 0 "" 2
	.arm
	.syntax unified
	str	r3, [r0, #12]
	bx	lr
	.size	add, .-add
	.align	2
	.global	shiftRight
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	shiftRight, %function
shiftRight:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r2, [r0, #12]
	ldr	r3, [r0, #8]
	.syntax divided
@ 25 "u128.c" 1
	lsrs r2, r2, #1;
@ 0 "" 2
@ 26 "u128.c" 1
	rrx r3, r3;
@ 0 "" 2
	.arm
	.syntax unified
	str	r2, [r0, #12]
	str	r3, [r0, #8]
	ldr	r2, [r0, #4]
	ldr	r3, [r0]
	.syntax divided
@ 27 "u128.c" 1
	rrx r2, r2;
@ 0 "" 2
@ 28 "u128.c" 1
	rrx r3, r3;
@ 0 "" 2
	.arm
	.syntax unified
	str	r2, [r0, #4]
	str	r3, [r0]
	bx	lr
	.size	shiftRight, .-shiftRight
	.align	2
	.global	shiftLeft
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	shiftLeft, %function
shiftLeft:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldrd	r2, [r0]
	.syntax divided
@ 36 "u128.c" 1
	lsls r2, r2, #1;
@ 0 "" 2
@ 39 "u128.c" 1
	lsls r3, r3, #1;
@ 0 "" 2
	.arm
	.syntax unified
	str	r2, [r0]
	.syntax divided
@ 40 "u128.c" 1
	addcs r3, r3, #1;
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r2, [r0, #8]
	str	r3, [r0, #4]
	.syntax divided
@ 43 "u128.c" 1
	lsls r2, r2, #1;
@ 0 "" 2
	.arm
	.syntax unified
	ldr	r3, [r0, #12]
	.syntax divided
@ 44 "u128.c" 1
	addcs r2, r2, #1;
@ 0 "" 2
@ 47 "u128.c" 1
	lsls r3, r3, #1;
@ 0 "" 2
	.arm
	.syntax unified
	str	r2, [r0, #8]
	.syntax divided
@ 48 "u128.c" 1
	addcs r3, r3, #1;
@ 0 "" 2
	.arm
	.syntax unified
	str	r3, [r0, #12]
	bx	lr
	.size	shiftLeft, .-shiftLeft
	.align	2
	.global	subtract
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	subtract, %function
subtract:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	bx	lr
	.size	subtract, .-subtract
	.align	2
	.global	bitLength
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	bitLength, %function
bitLength:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, [r0]
	cmp	r3, #0
	bne	.L10
	ldr	r3, [r0, #4]
	cmp	r3, #0
	movne	r0, #0
	beq	.L14
.L9:
	lsrs	r3, r3, #1
	add	r0, r0, #1
	bne	.L9
	bx	lr
.L10:
	mov	r0, #64
	b	.L9
.L14:
	mov	r0, r3
	bx	lr
	.size	bitLength, .-bitLength
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfpv3-d16
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r10, fp, lr}
	mov	r2, #0
	.syntax divided
@ 17 "u128.c" 1
	adc r5, r2, r2;
@ 0 "" 2
@ 25 "u128.c" 1
	lsrs r8, r2, #1;
@ 0 "" 2
@ 26 "u128.c" 1
	rrx r7, r2;
@ 0 "" 2
	.arm
	.syntax unified
	mov	r10, #1
	mvn	fp, #-2147483648
	sub	sp, sp, #24
	add	r0, sp, #8
	mvn	r1, #-2147483648
	.syntax divided
@ 16 "u128.c" 1
	adc r6, r1, r1;
@ 0 "" 2
@ 27 "u128.c" 1
	rrx r4, r1;
@ 0 "" 2
	.arm
	.syntax unified
	str	r2, [sp, #16]
	str	r2, [sp, #20]
	strd	r10, [sp, #8]
	bl	shiftLeft
	movw	r0, #:lower16:.LC0
	str	r5, [sp]
	mov	r3, r5
	mov	r2, r6
	mov	r5, #1
	.syntax divided
@ 15 "u128.c" 1
	adds r1, r5, r5;
@ 0 "" 2
@ 28 "u128.c" 1
	rrx r6, r5;
@ 0 "" 2
	.arm
	.syntax unified
	movt	r0, #:upper16:.LC0
	bl	printf
	movw	r0, #:lower16:.LC1
	mov	r3, r7
	mov	r2, r4
	mov	r1, r6
	str	r8, [sp]
	movt	r0, #:upper16:.LC1
	bl	printf
	movw	r0, #:lower16:.LC2
	ldr	r3, [sp, #20]
	ldr	r1, [sp, #8]
	str	r3, [sp]
	ldrd	r2, [sp, #12]
	movt	r0, #:upper16:.LC2
	bl	printf
	mov	r0, r5
	add	sp, sp, #24
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r10, fp, pc}
	.size	main, .-main
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"s: %u %u %u %u\012\000"
.LC1:
	.ascii	"b: %u %u %u %u\012\000"
.LC2:
	.ascii	"c: %u %u %u %u\012\000"
	.ident	"GCC: (GNU) 8.2.1 20180801 (Red Hat 8.2.1-2)"
	.section	.note.GNU-stack,"",%progbits
