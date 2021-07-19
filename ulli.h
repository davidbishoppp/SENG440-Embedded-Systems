#include <stdio.h>
#include <stdlib.h>

/**
 * ulli arrays: x[0] = high bits, x[1] = low bits.
 */
typedef unsigned long long int ulli; // 64bits (2 registers)

/**
 * Bit shift right a 128bit number through ulli.
 * 
 * @param x Operand
 */
void shiftRight(ulli* x) {
	int underflow = x[0] & 1;
	x[0] >>= 1; // Shift high
	x[1] >>= 1; // Shift low
	if (underflow) {
		x[1] += 0x80000000;
	}
}

/**
 * Bit shift left a 128bit number through ulli.
 * 
 * @param x Operand
 */
void shiftLeft(ulli* x) {
	int carry = x[0] & 0x80000000;
	x[0] <<= 1;
	x[1] <<= 1;
	if (carry) {
		x[1] += 1;
	}
}

/**
 * Add two 128bit numbers through ulli.
 * TODO: Convert to Assembly? ADC operation may be useful.
 * 
 * @param x Operand 1
 * @param y Operand 2
 * @param z x + y
 */
void add(ulli* x, ulli* y, ulli* z) {
	z[1] = x[1] + y[1];
	// Check if adding lows will wrap.
	int carry = 0;
	if (((x[1] > 0) && (y[1] > UINT64_MAX - x[1])) || ((y[1] > 0) && (x[1] > UINT64_MAX - y[1]))) { // Will wrap.
		carry = 1;
	}
	z[0] = x[0] + y[0] + carry;
}

/**
 * Subtract two 128bit numbers through ulli.
 * TODO: Convert to Assembly? ADC operation may be useful.
 * https://www.prodevelopertutorial.com/add-and-subtract-2-numbers-using-bitwise-operators-c-solution/
 * 
 * @param x Operand 1
 * @param y Operand 2
 */
void subtract(ulli* x, ulli* y, ulli* z) {
	ulli* y_local = malloc(sizeof(ulli)*2);
	y_local[0] = y[0];
	y_local[1] = y[1];
	ulli* carry = malloc(sizeof(ulli)*2);
	while (y_local[0] != 0 && y_local[1] != 0) {
		carry[0] = x[0] & y_local[0];
		carry[1] = x[1] & y_local[1];
		z[0] = x[0] ^ y_local[0];
		z[1] = x[1] ^ y_local[1];
		y_local[0] = carry[0];
		y_local[1] = carry[1];
		shiftLeft(y_local);
	}
	free(carry);
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

/**
 * Returns a new ulli from bitLength.
 * 
 * @param c Char array.
 */
ulli* ulliFromCharArray(char* c) {
	ulli* temp = malloc(sizeof(ulli)*2);
	temp[0] = 0LL;
	temp[0] = 0LL;
	temp[0] |= (b > 64) ? (1 << (b-64)) : (1 << b);
	return temp;
}
