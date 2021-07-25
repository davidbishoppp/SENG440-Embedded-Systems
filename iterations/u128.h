#include <stdio.h>

#define LENGTH 4

/**
 * u128 arrays: x[0] = low bits, x[3] = high bits.
 */
typedef unsigned int u128; // 64bits (2 registers)

/**
 * Bit shift right a 128bit number through u128.
 * 
 * @param x Operand
 */
void shiftRight(u128* x) {
	int underflow = x[1] & 1;
	x[0] >>= 1; // Shift low
	x[1] >>= 1; // Shift high
	if (underflow) {
		x[1] += 0x80000000;
	}
}

/**
 * Bit shift left a 128bit number through u128.
 * 
 * @param x Operand
 */
void shiftLeft(u128* x) {
	int carry = x[0] & 0x80000000;
	x[0] <<= 1;
	x[1] <<= 1;
	if (carry) {
		x[1] += 1;
	}
}

/**
 * Add two 128bit numbers through u128.
 * 
 * @param result = x + y
 * @param x Operand 1
 * @param y Operand 2
 */
void add(u128* result, u128* x, u128* y) {
	result[0] = x[0] + y[0]; // Add low bits.
	
	int carry = 0;
	if (((x[0] > 0) && (y[0] > __UINT32_MAX__ - x[0]))) { // Will wrap.
		carry = 1;
	}
	result[1] = x[1] + y[1] + carry; // Add high bits.
}

/**
 * Subtract two 128bit numbers through u128.
 * 
 * @param x Operand 1
 * @param y Operand 2
 */
void subtract(u128* result, u128* x, u128* y) {
	u128 y_local[LENGTH] = {y[0], y[1]};
	u128 carry[LENGTH];
	while (y_local[0] != 0 && y_local[1] != 0) {
		carry[0] = x[0] & y_local[0];
		carry[1] = x[1] & y_local[1];
		result[0] = x[0] ^ y_local[0];
		result[1] = x[1] ^ y_local[1];
		y_local[0] = carry[0];
		y_local[1] = carry[1];
		shiftLeft(y_local);
	}
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