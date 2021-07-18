#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long int ulli;

int bitLength(int M) {
	int count = 0;

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
int MMM(int X, int Y, int M) {
	const int M_const = M;
	int T = 0;
	int n;

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
int MMM_without_scale(int X, int Y, int M, int R, int R2) {
	int const X_bar = MMM(X, R2, M);
	int const Y_bar = MMM(Y, R2, M);
	int const Z_bar = MMM(X_bar, Y_bar, M);
	return MMM(Z_bar, 1, M);
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @return Z = X^E mod M
 */
int ME_MMM(int X, int E, int M) {
	int const R = (1 << bitLength(M))%M;
	int const R2 = (R*R)%M;
	int z = 1;
	int p = X;
	while (E != 0) {
		if(E & 1) {
			z = MMM_without_scale(z, p, M, R, R2);
		}
		p = MMM_without_scale(p, p, M, R, R2);

		E >>= 1;
	}
	return z;
}