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
	.file	"test.c"
	.text
	.comm	a,16,8
	.comm	b,16,8
	.comm	c,16,8
	.section	.rodata
	.align	2
.LC0:
	.ascii	"a: low %llu high: %llu\012\000"
	.text
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu neon
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r1, .L4+16
	adr	r3, .L4
	ldrd	r2, [r3]
	strd	r2, [r1]
	ldr	r1, .L4+16
	adr	r3, .L4+8
	ldrd	r2, [r3]
	strd	r2, [r1, #8]
	ldr	r3, .L4+16
	ldrd	r0, [r3]
	ldr	r3, .L4+16
	ldrd	r2, [r3, #8]
	strd	r2, [sp]
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L4+20
	bl	printf
	ldr	r3, .L4+16
	vld1.64	{d16-d17}, [r3:64]
	vstr	d16, [fp, #-20]
	vstr	d17, [fp, #-12]
	vldr	d16, [fp, #-20]
	vldr	d17, [fp, #-12]
	vrev64.32	q8, q8
	ldr	r3, .L4+16
	vst1.64	{d16-d17}, [r3:64]
	ldr	r3, .L4+16
	ldrd	r0, [r3]
	ldr	r3, .L4+16
	ldrd	r2, [r3, #8]
	strd	r2, [sp]
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L4+20
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L5:
	.align	3
.L4:
	.word	33752069
	.word	1
	.word	101124105
	.word	5
	.word	a
	.word	.LC0
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
