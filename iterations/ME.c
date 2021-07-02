/**
 * Basic Modular Exponentiation implementation
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int main(int argc, char* argv[]) {
	int P = 61; //first prime
	int Q = 53; //second prime
	int E = 17; //public exponent
	int D = 2753; //private exponent

	int encrypted = 855; //encrypted plaintext
	int decrypted = 123; //decrypted cypher

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
	return 1;
}