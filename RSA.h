/**
 * ARM computers have 16 32bit registers.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ulli.h"

/**
 * Computes R from bitlength
 * 
 * @param b Bit length
 * @return New allocated ulli
 */
ulli* NewR(int b) {
	ulli* temp = malloc(sizeof(ulli)*2);
	temp[0] = 0LL;
	temp[1] = 0LL;
	if (b == 0 || b > 128) {
		return temp;
	}
	temp[0] |= (b > 64) ? (1 << (b-64)) : (1 << b);
	return temp;
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
		n = (Z[1] & 1) ^ ((X[0] & 1) & (Y[0] & 1));
		if (n) {
			add(Z, M, Z);
		}
		if (X[0] & 1) {
			add(Z, Y, Z);
		}
		shiftRight(X);
	}
	// If T >= M
	if ((Z[0] > M[0]) || ((Z[0] = M[0]) && (Z[1] >= M[1]))) {
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
	ulli* R2 = NewR(b << 1); // R^2 = 2^2b
	ulli X_bar[2] = {0LL, 0LL};
	ulli Y_bar[2] = {0LL, 0LL};
	ulli Z_bar[2] = {0LL, 0LL};
	ulli temp[2] = {0LL, 1LL};
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
	while (E != 0) {
		if(E[1] & 1) {
			MMM_without_scale(Z, X, M, Z);
		}
		MMM_without_scale(X, X, M, X);

		shiftRight(E);
	}
}