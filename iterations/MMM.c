/**
 * Basic Modular Exponentiation with Montgomery Modular Multiplication implementation.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
 * @param X Operand 1. 0 <= X < R
 * @param Y Operand 2. 0 <= Y < R
 * @param M Modulo
 * @return T = X*Y*(R^-1) mod M
*/
int MMM(int X, int Y, int M) {
	const int M_const = M;
	int T = 0;
	int n;

	while(M > 0) {
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
 * @param X Operand 1. 0 <= X < R
 * @param Y Operand 2. 0 <= Y < R
 * @param M Modulo
 * @return T = X*Y mod M
*/
int MMM_without_scale(int X, int Y, int M, int R, int R2) {
	int const X_bar = MMM(X, R2, M);
	int const Y_bar = MMM(Y, R2, M);
	int const Z_bar = MMM(X_bar, Y_bar, M);
	return MMM(Z_bar, 1, M);
}

int main() {
	int X = 123;
	int Y = 456;
	int P = 61; //first prime
	int Q = 53; //second prime
	int M = P*Q;
	int R = (1 << bitLength(M))%M;
	int R2 = (R*R)%M;

	printf("\n--- Starting Montgomery Modular Multiplication Test ---\n");

	int z = MMM_without_scale(X, Y, M, R, R2);
	int expected = 1127;
	if (z != expected) {
		printf("MMM does not match.\n");
		printf("Expected: %i\nActual: %i\n", expected, z);
		return 0;
	} else {
		printf("MMM successfully!\n");
	}

	return 1;
}