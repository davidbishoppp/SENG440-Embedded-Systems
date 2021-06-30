#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

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
 * Computes UNOPTIMIZED Modular Exponentiation
 * @param X data (either decrypted or encrypted int) (base)
 * @param E exponent (exponential)
 * @param M PQ (divisor)
 * @return Z = X^E % M
 */
int ME(int X, int E, int M ) {
	int Z = 1;

	X = X % M;

	while(E > 0) {
		// First bit set
		if(E & 1) {
			Z = (Z * X) % M;
		}

		//shift bits by 1 
		E >>= 1;
		X = (X * X) % M;
	}

	return Z;
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
		n = (T & 1) + ((X & 1) * (Y & 1));
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
 * Computes Modular Exponentiation with MMM
 * @param X Base
 * @param E Exponent
 * @param M Modulo
 * @return Z = X^E mod M
 */
int ME_MMM(int X, int E, int M ) {
	const int M_const = M;
	int R = 1 << bitLength(M);
	int z = R % M; // TODO: Can we get rid of these modulos?
	int p = MMM(X, (R*R % M), M); // TODO: Can we get rid of these modulos?

	while (M > 0) {
		if(E & 1) {
			z = MMM(z, p, M_const);
		}
		p = MMM(p, p, M_const);

		M >>= 1;
		E >>= 1;
	}

	return MMM(1, z, M_const);
}

int main(int argc, char* argv[]) {
	if (argc != 7) {
		printf("Need P, Q, E, D and the encripted/dectripted text!\n");
		printf("Got:\n");
		for (int i = 1; i < argc; i++) {
			printf("%s\n", argv[i]);
		}
		return 0;
	}

	int P = atoi(argv[1]); //first prime
	int Q = atoi(argv[2]); //second prime
	int E = atoi(argv[3]); //public exponent
	int D = atoi(argv[4]); //private exponent

	int encrypted = atoi(argv[5]); //encrypted plaintext
	int decrypted = atoi(argv[6]); //decrypted cypher

	printf("--- starting modular exponential method test ---\n");
	
	int enrcypt_test_me = ME(decrypted, E, (P*Q));
	if (encrypted != enrcypt_test_me) {
		printf("ME encryption does not match.\n");
		printf("Expected: %i\nActual: %i\n", encrypted, enrcypt_test_me);
		return 0;
	} else {
		printf("ME encrypted successfully!\n");
	}

	int decrypt_test_me = ME(encrypted, D, (P*Q));
	if (decrypted != decrypt_test_me) {
		printf("ME decryption does not match.\n");
		printf("Expected: %i\nActual: %i\n", decrypted, decrypt_test_me);
		return 0;
	} else {
		printf("ME decrypted successfully!\n");
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