/**
 * RSA encryption and decryption with unsigned long long integers only.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long int ulli;

ulli bitLength(ulli M) {
	ulli count = 0;

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
ulli MMM(ulli X, ulli Y, ulli M) {
	const ulli M_const = M;
	ulli T = 0;
	ulli n;

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
ulli MMM_without_scale(ulli X, ulli Y, ulli M) {
	ulli const R2 = (1 << (bitLength(M) << 1))%M;
	ulli const X_bar = MMM(X, R2, M);
	ulli const Y_bar = MMM(Y, R2, M);
	ulli const Z_bar = MMM(X_bar, Y_bar, M);
	ulli tmp = MMM(Z_bar, 1, M);
	return tmp;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @return Z = X^E mod M
 */
ulli ME_MMM(ulli X, ulli E, ulli M) {
	ulli Z = 1;
	while (E != 0) {
		if(E & 1) {
			Z = MMM_without_scale(X, Z, M);
		}
		X = MMM_without_scale(X, X, M);
		E >>= 1;
	}
	return Z;
}

// printf("\n");
// printf("1\n");
// printf("Z: %llu\n", Z);
// printf("X: %llu\n", X);
// printf("E: %llu\n", E);
// printf("M: %llu\n", M);

// int main(void) {
// 	// Example values from slides.
// 	//ulli P = 61;
// 	//ulli Q = 53;
// 	ulli M = 3233;

// 	ulli E = 17;
// 	ulli D = 2753LLU;

// 	ulli message = 123;

// 	ulli X = 100;
// 	ulli Y = 863; // R = (1<<12) % 3233 = 863

// 	ulli test1 = MMM(X, Y, M);

// 	printf("test1: %i\n", test1); // Expect 100.

// 	ulli test2 = MMM_without_scale(X, Y, M);

// 	printf("test2: %i\n", test2); // Expect 2242.

// 	ulli test3 = ME_MMM(message, E, M);

// 	printf("test3: %i\n", test3); // Expect 855.

// 	ulli test4 = ME_MMM(test3, D, M);

// 	printf("test4: %i\n", test4); // Expect 123.

// }