#include <stdio.h>
#include <stdlib.h>

/**
 * [0] = lowest bits
 * [3] = highest bits
 */
typedef unsigned int u128;

/**
 * result = a + b
 */
void add(u128* result, u128* a, u128* b) {
	__asm__("adds %0, %1, %2;" : "=r" (result[0]) : "r" (a[0]), "r" (b[0]));
	__asm__("adc %0, %1, %2;" : "=r" (result[1]) : "r" (a[1]), "r" (b[1]));
	__asm__("adc %0, %1, %2;" : "=r" (result[2]) : "r" (a[2]), "r" (b[2]));
	__asm__("adc %0, %1, %2;" : "=r" (result[3]) : "r" (a[3]), "r" (b[3]));
}

/**
 * Bit shift right a 128bit number.
 */
void shiftRight(register u128* a) {
	__asm__("lsrs %0, %1 #1;" : "=r" (a[3]) : "r" (a[3]));
	__asm__("rrx %0, %1;" : "=r" (a[2]) : "r" (a[2]));
	__asm__("rxx %0, %1;" : "=r" (a[1]) : "r" (a[1]));
	__asm__("rxx %0, %1;" : "=r" (a[0]) : "r" (a[0]));
}

/**
 * Bit shift left a 128bit number.
 */
void shiftLeft(register u128* a) {
	// Shift lowest bits.
	__asm__("lsls %0, %1, #1;" : "=r" (a[0]) : "r" (a[0]));

	// Shift next set of bits. Add 1 if carry flag set.
	__asm__("lsls %0, %1, #1;" : "=r" (a[1]) : "r" (a[1]));
	__asm__("addcs %0, %1, #1;" : "=r" (a[1]) : "r" (a[1]));

	// Shift next set of bits. Add 1 if carry flag set.
	__asm__("lsls %0, %1, #1;" : "=r" (a[2]) : "r" (a[2]));
	__asm__("addcs %0, %1, #1;" : "=r" (a[2]) : "r" (a[2]));

	// Shift hgihest bits. Add 1 if carry flag set.
	__asm__("lsls %0, %1, #1;" : "=r" (a[3]) : "r" (a[3]));
	__asm__("addcs %0, %1, #1;" : "=r" (a[3]) : "r" (a[3]));
}

/**
 * Subtract two 128bit numbers through u128.
 */
void subtract(u128* result, u128* a, u128* b) {
	__asm__("subs %0, %1, %2;" : "=r" (result[0]) : "r" (a[0]), "r" (b[0]));
	__asm__("sbcs %0, %1, %2;" : "=r" (result[1]) : "r" (a[1]), "r" (b[1]));
	__asm__("sbcs %0, %1, %2;" : "=r" (result[2]) : "r" (a[2]), "r" (b[2]));
	__asm__("sbcs %0, %1, %2;" : "=r" (result[3]) : "r" (a[3]), "r" (b[3]));
}

/**
 * Bit length of a 128but number through u128.
 */
int bitLength(u128* a) {
	int count = 0;
	u128 tmp = a[0];
	if (a[3] != 0) {
		tmp = a[3];
		count = 96;
	} else if (a[2] != 0) {
		tmp = a[2];
		count = 64;
	}else if (a[1] != 0) {
		tmp = a[1];
		count = 32;
	}
	while(tmp != 0) {
		count++;
		tmp >>= 1;
	}
	return count;
}