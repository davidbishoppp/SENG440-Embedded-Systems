#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int bitLength(int M) {
	int count = 0;

	while(M > 0) {
		count++;
		//bit shift
		M >>= 1;
	}

	return count;
}

// X: data (either decrypted or encrypted int) (base)
// E: public exponent (exponential)
// M: PQ (divisor)
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

int MMM(int X, int Y, int M) {
	const int M_const = M;
	int T = 0;
	int n;

	//printf("i | X(i) | n | T\n"); int i = 0;
	while(M > 0) {
		n = (T & 1) ^ ((X & 1) & (Y & 1));
		T = (T + ((X & 1) * Y) + (n * M_const)) >> 1;
		//printf("%i | %i | %i | %i\n", i, (X & 1), n, T); i++;

		// shift bits by 1
		X >>= 1;
		M >>= 1;
	}
	if (T >= M) {
		T = T - M;
	}
	return T;
}

/* 
Adapted from paper and github linked...
- Lines 106/107 are just setting Z equal to R which is 2^m
- Line 108 sets P to X*R = X*Z
*/
int MEwithMMM(int X, int E, int M ) {
	int Z = 1 << bitLength(M);
	int P = X * Z;

	while(E > 0) {
		// First bit set
		if(E & 1) {
			Z = MMM(Z, P, M);
		}

		//shift bits by 1 
		E >>= 1;
		X = MMM(X, X, M);
	}

	return MMM(Z, 1, M);
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

	int enrcypt_test_mm = MEwithMMM(decrypted, E, (P*Q));
	if (encrypted != enrcypt_test_mm) {
		printf("MMM encryption does not match.\n");
		printf("Expected: %i\nActual: %i\n", encrypted, enrcypt_test_mm);
		return 0;
	} else {
		printf("MMM encrypted successfully!\n");
	}

	int decrypt_test_mm = MEwithMMM(encrypted, D, (P*Q));
	if (decrypted != decrypt_test_mm) {
		printf("MMM decryption does not match\n");
		printf("Expected: %i\nActual: %i\n", decrypted, decrypt_test_mm);
		return 0;
	} else {
		printf("MMM decrypted successfully!\n");
	}

	return 1;
}