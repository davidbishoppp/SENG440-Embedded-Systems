
	[NO ASSIST]

	add	fp, sp, #4 -1c
	mov	r2, r1 -1c
	and	r3, r4, #1 -1c
	cmp	r3, #0 -1 c
	beq	.L60 - 3 cycles
	add	r4, r4, r2 -1c
.L60:
	lsr	r4, r4, #1 -1c

9 vs 5, almost 2x


	[ASSIST]

	add	fp, sp, #4 -1c
	mov	r3, r1 -1c
	.syntax divided
@ 100 "./src/RSA.h" 1
	mmm_1_hw	r4, r3, r3 -3c

@ 0 "" 2

