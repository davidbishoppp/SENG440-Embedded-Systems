#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

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
void shiftRight(u128* a) {
	__asm__("lsrs %0, %1, #1;" : "=r" (a[3]) : "r" (a[3]));
	__asm__("rrx %0, %1;" : "=r" (a[2]) : "r" (a[2]));
	__asm__("rrx %0, %1;" : "=r" (a[1]) : "r" (a[1]));
	__asm__("rrx %0, %1;" : "=r" (a[0]) : "r" (a[0]));
}

/**
 * Bit shift left a 128bit number.
 */
void shiftLeft(u128* a) {
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
 * TODO: Convert to Assembly? ADC operation may be useful.
 * https://www.prodevelopertutorial.com/add-and-subtract-2-numbers-using-bitwise-operators-c-solution/
 * 
 * @param x Operand 1
 * @param y Operand 2
 */
void subtract(u128* x, u128* y, u128* z) {
	
}

/**
 * Bit length of a 128but number through u128.
 * 
 * @param x Operand
 */
int bitLength(u128* x) {
	int count;
	u128 tmp;
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

int main(void) {
	u128 a[4] = {1, INT_MAX};
	u128 b[4] = {1, INT_MAX};
	u128 c[4] = {1, INT_MAX};

	u128 s[4];
	add(s, a, b);
	shiftRight(b);
	shiftLeft(c);

	printf("s: %u %u %u %u\n", s[0], s[1], s[2], s[3]);
	printf("b: %u %u %u %u\n", b[0], b[1], b[2], b[3]);
	printf("c: %u %u %u %u\n", c[0], c[1], c[2], c[3]);
	return 1; 
}
