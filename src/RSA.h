#include <stdio.h>
#include <stdlib.h>
#include "ulli.h"

/**
 * Computes R from bitlength
 * 
 * @param b Bit length
 * @return New allocated ulli
 */
void newR(ulli* result, int b) {
	if (b == 0 || b > 128) {
		return;
	} else if (b > 64) {
		result[HIGH] |= (1 << (b-64));
	} else {
		result[LOW] |= (1 << b);
	}
}

/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @param Z = X*Y*R^-1 % M
*/
void MMM(ulli* X, ulli* Y, ulli* M, ulli* Z) {
	int n;
	int i;
	const int length = bitLength(M);
	for (i = 0; i < length; i++) {
		n = (Z[LOW] & 1) ^ ((X[LOW] & 1) & (Y[LOW] & 1));
		if (n) {
			add(Z, M, Z);
		}
		if (X[LOW] & 1) {
			add(Z, Y, Z);
		}
		shiftRight(X);
	}
	// If T >= M
	if (greaterThan(Z, M)) {
		subtract(Z, M, Z);
	}
}

/**
 * Computes Montgomery Modular Multiplication without scale factor R^-1
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return T = X*Y mod M
*/
void MMM_without_scale(ulli* X, ulli* Y, ulli* M, ulli* Z) {
	const int b = bitLength(M);
	ulli R2[LENGTH];
	newR(R2, b << 1); // R^2 = 2^2b
	while (greaterThan(R2, M)) {
		subtract(R2, R2, M);
	}
	ulli X_bar[LENGTH] = {0LLU, 0LLU};
	ulli Y_bar[LENGTH] = {0LLU, 0LLU};
	ulli Z_bar[LENGTH] = {0LLU, 0LLU};
	ulli temp[LENGTH];
	temp[HIGH] = 0LLU;
	temp[LOW] = 1LLU;
	MMM(X, R2, M, X_bar);
	MMM(Y, R2, M, Y_bar);
	MMM(X_bar, Y_bar, M, Z_bar);
	MMM(Z_bar, temp, M, Z);
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @param Z = X^E mod M
 */
void ME_MMM(ulli* X, ulli* E, ulli* M, ulli* Z) {
	while (E[LOW] != 0LLU || E[HIGH] != 0LLU) {
		printUlli(Z, "Z");
		printUlli(X, "X");
		printUlli(E, "E");
		if(E[LOW] & 1LLU) {
			MMM_without_scale(Z, X, M, Z);
		}
		MMM_without_scale(X, X, M, X);
		shiftRight(E);
	}
}