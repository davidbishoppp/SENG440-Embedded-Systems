#include <stdio.h>
#include <stdlib.h>
#include "ulli.h"

/**
 * Computes R from bitlength
 * 
 * @param b Bit length
 */
ulli* newR(int b) {
	ulli* result = newUlli(0);
	if (b == 0 || b > 128) {
		return result;
	} else if (b > 64) {
		result[HIGH] |= (1 << (b-64));
	} else {
		result[LOW] |= (1 << b);
	}
	return result;
}

/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @param Z = X*Y*R^-1 % M
*/
ulli* MMM(ulli* X, ulli* Y, ulli* M) {
	ulli* Z = newUlli(0);
	ulli* X_local = copyUlli(X);
	int n;
	int i;
	const int length = bitLength(M);
	for (i = 0; i < length; i++) {
		n = (Z[LOW] & 1) ^ ((X_local[LOW] & 1) & (Y[LOW] & 1));
		if (n) {
			add(Z, M, Z);
		}
		if (X_local[LOW] & 1) {
			add(Z, Y, Z);
		}
		shiftRight(X_local);
		shiftRight(Z);
	}
	// If T >= M
	if (greaterThan(Z, M)) {
		subtract(Z, Z, M);
	}
	free(X_local);
	return Z;
}

/**
 * Computes Montgomery Modular Multiplication without scale factor R^-1
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return T = X*Y mod M
*/
ulli* MMM_without_scale(ulli* X, ulli* Y, ulli* M, ulli* R2) {
	ulli* one = newUlli(1);
	ulli* X_bar = MMM(X, R2, M);
	ulli* Y_bar = MMM(Y, R2, M);
	ulli* Z_bar = MMM(X_bar, Y_bar, M);
	ulli* temp = MMM(Z_bar, one, M);
	
	free(one);
	free(X_bar);
	free(Y_bar);
	free(Z_bar);

	return temp;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @param Z = X^E mod M
 */
ulli* ME_MMM(ulli* X, ulli* E, ulli* M, ulli* R2) {
	ulli* Z = newUlli(1);
	ulli* E_local = copyUlli(E);
	while (E_local[LOW] != 0LLU || E_local[HIGH] != 0LLU) {
		if(E_local[LOW] & 1LLU) {
			Z = MMM_without_scale(X, Z, M, R2);
		}
		X = MMM_without_scale(X, X, M, R2);
		shiftRight(E_local);
	}
	free(E_local);
	return Z;
}

// int main(void) {
// 	// Example values from slides.
// 	//ulli P[2] = {0LLU, 61LLU};
// 	//ulli Q[2] = {0LLU, 53LLU};
// 	ulli M[2] = {0LLU, 0xD1CDBEDF21979C1}; // 944871836856449473 = 0xD1CDBEDF21979C1

// 	ulli E[2] = {0LLU, 0x402896F3942E14B}; // 288944436900192587 = 0x402896F3942E14B
// 	ulli D[2] = {0LLU, 0xCEE375AFDE45633}; // 931743036858455603 = 0xCEE375AFDE45633

// 	ulli message[2] = {0LLU, 123LLU};

// 	ulli X[2] = {0LLU, 100LLU};
// 	ulli Y[2] = {0LLU, 863LLU}; // R = (1<<12) % 3233 = 863

// 	ulli* test1 = MMM(X, Y, M);

// 	printUlli(test1, "test1"); // Expect 100.

// 	ulli* test2 = MMM_without_scale(X, Y, M);

// 	printUlli(test2, "test2"); // Expect 2242.

// 	ulli* test3 = ME_MMM(message, E, M);

// 	printUlli(test3, "test3"); // Expect 855.

// 	ulli* test4 = ME_MMM(test3, D, M);

// 	printUlli(test4, "test4"); // Expect 123.
// }