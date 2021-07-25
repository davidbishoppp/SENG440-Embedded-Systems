#include <stdio.h>
#include <stdlib.h>

/**
 * ulli arrays: x[0] = low bits, x[1] = high bits.
 */
typedef unsigned long long int ulli; // 64bits (2 registers)

/**
 * result = a + b
 */
void add(ulli* result, ulli* a, ulli* b) {
	__asm__("adds %0, %1, %2;" : "=r" (result[0]) : "r" (a[0]), "r" (b[0]));
	__asm__("adc %0, %1, %2;" : "=r" (result[1]) : "r" (a[1]), "r" (b[1]));
}

/**
 * Bit shift right a 128bit number.
 */
void shiftRight(register ulli* a) {
	__asm__("lsrs %0, %1 #1;" : "=r" (a[1]) : "r" (a[1]));
	__asm__("rrx %0, %1;" : "=r" (a[0]) : "r" (a[0]));
}

/**
 * Bit shift left a 128bit number.
 */
void shiftLeft(register ulli* a) {
	// Shift lowest bits.
	__asm__("lsls %0, %1, #1;" : "=r" (a[0]) : "r" (a[0]));

	// Shift highest bits.
	__asm__("lsls %0, %1, #1;" : "=r" (a[1]) : "r" (a[1]));
	__asm__("addcs %0, %1, #1;" : "=r" (a[1]) : "r" (a[1]));
}

/**
 * Subtract two 128bit numbers through ulli.
 */
void subtract(ulli* result, ulli* a, ulli* b) {
	__asm__("subs %0, %1, %2;" : "=r" (result[0]) : "r" (a[0]), "r" (b[0]));
	__asm__("sbcs %0, %1, %2;" : "=r" (result[1]) : "r" (a[1]), "r" (b[1]));
}

/**
 * Bit length of a 128but number through ulli.
 * 
 * @param x Operand
 */
int bitLength(ulli* x) {
	int count;
	ulli tmp;
	if (x[0] != 0) {
		tmp = x[0];
		count = 64;
	} else {
		tmp = x[1];
		count = 0;
	}
	while(tmp != 0) {
			count++;
			tmp >>= 1;
		}
	return count;
}