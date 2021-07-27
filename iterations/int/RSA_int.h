#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned int bitLength(unsigned int M) {
	unsigned int count = 0;

	while(M > 0) {
		count++;
		//bit shift
		M >>= 1;
	}

	return count;
}

/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return T = X*Y*(R^-1) mod M
*/
unsigned int MMM(unsigned int X, unsigned int Y, unsigned int M) {
	const unsigned int M_const = M;
	unsigned int T = 0;
	unsigned int n;

	while(M != 0) {
		// TODO: remove * if possible?
		n = (T & 1) ^ ((X & 1) & (Y & 1));
		T = (T + ((X & 1) * Y) + (n * M_const)) >> 1;

		M >>= 1;
		X >>= 1;
	}
	if (T >= M_const) {
		T = T - M_const;
	}
	return T;
}

/**
 * Computes Montgomery Modular Multiplication without scale factor R^-1
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return T = X*Y mod M
*/
unsigned int MMM_without_scale(unsigned int X, unsigned int Y, unsigned int M) {
	unsigned int const R2 = (1 << (bitLength(M) << 1))%M;
	unsigned int const X_bar = MMM(X, R2, M);
	unsigned int const Y_bar = MMM(Y, R2, M);
	unsigned int const Z_bar = MMM(X_bar, Y_bar, M);
	unsigned int tmp = MMM(Z_bar, 1, M);
	return tmp;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @return Z = X^E mod M
 */
unsigned int ME_MMM(unsigned int X, unsigned int E, unsigned int M) {
	unsigned int Z = 1;
	while (E != 0) {
		if(E & 1) {
			Z = MMM_without_scale(X, Z, M);
		}
		X = MMM_without_scale(X, X, M);
		E >>= 1;
	}
	return Z;
}

// int main(void) {
// 	// Example values from slides.
// 	//unsigned int P = 61;
// 	//unsigned int Q = 53;
// 	unsigned int M = 3233;

// 	unsigned int E = 17;
// 	unsigned int D = 2753LLU;

// 	unsigned int message = 123;

// 	unsigned int X = 100;
// 	unsigned int Y = 863; // R = (1<<12) % 3233 = 863

// 	unsigned int test1 = MMM(X, Y, M);

// 	printf("test1: %i\n", test1); // Expect 100.

// 	unsigned int test2 = MMM_without_scale(X, Y, M);

// 	printf("test2: %i\n", test2); // Expect 2242.

// 	unsigned int test3 = ME_MMM(message, E, M);

// 	printf("test3: %i\n", test3); // Expect 855.

// 	unsigned int test4 = ME_MMM(test3, D, M);

// 	printf("test4: %i\n", test4); // Expect 123.

// }