#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// TODO: make inline?
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
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return T = X*Y mod M
*/
int MMM_without_scale(int X, int Y, int M ) {
	int const R = 1 << bitLength(M);
	int Xbar = MMM(X, (R*R % M), M);
	int Ybar = MMM(Y, (R*R % M), M);
	int Zbar = MMM(Xbar, Ybar, M);
	int ret = MMM(Zbar, 1, M);

	//printf("X: %i\n", X);
	//printf("Y: %i\n", Y);
	//printf("M: %i\n", M);
	//printf("R: %i\n", R);
	//printf("Xbar: %i\n", Xbar);
	//printf("Ybar: %i\n", Ybar);
	//printf("Zbar: %i\n", Zbar);
	//printf("ret: %i\n", ret);
	return ret;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @return Z = X^E mod M
 */
int ME_MMM(int X, int E, int M) {
	int Z = 1;
	int i;
	printf("Z start: %i\n", Z);
	printf("X start: %i\n", X);
	while(E > 0) {
		if(E & 1) {
			Z = MMM_without_scale(Z, X, M);
			printf("Z next: %i\n", Z);
		}
		X = MMM_without_scale(X, X, M);
		printf("X next: %i\n", X);
		E >>= 1;
	}
	printf("ret: %i\n", Z);
	return Z;
}

int main(int argc, char* argv[]) {
	int P = 61; //first prime
	int Q = 53; //second prime
	int E = 17; //public exponent
	int D = 2753; //private exponent

	int encrypted = 855; //encrypted plaintext
	int decrypted = 123; //decrypted cypher

	if (argc == 7) {
		P = atoi(argv[1]); //first prime
		Q = atoi(argv[2]); //second prime
		E = atoi(argv[3]); //public exponent
		D = atoi(argv[4]); //private exponent

		encrypted = atoi(argv[5]); //encrypted plaintext
		decrypted = atoi(argv[6]); //decrypted cypher
	}

	printf("\n--- starting montgomery multiplication method test ---\n");

	int enrcypt_test_mm = ME_MMM(decrypted, E, (P*Q));
	if (encrypted != enrcypt_test_mm) {
		printf("MMM encryption does not match.\n");
		printf("Expected: %i\nActual: %i\n", encrypted, enrcypt_test_mm);
		return 0;
	} else {
		printf("MMM encrypted successfully!\n");
	}

	int decrypt_test_mm = ME_MMM(encrypted, D, (P*Q));
	if (decrypted != decrypt_test_mm) {
		printf("MMM decryption does not match\n");
		printf("Expected: %i\nActual: %i\n", decrypted, decrypt_test_mm);
		return 0;
	} else {
		printf("MMM decrypted successfully!\n");
	}

	return 1;
}