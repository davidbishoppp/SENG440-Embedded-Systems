#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RSA.h"
#include "ulli.h"

int main(int argc, char* argv[]) {
	ulli* P; //first prime
	ulli* Q; //second prime
	ulli* E; //public exponent
	ulli* D; //private exponent
	ulli* message; //encrypted plain text
	ulli* encrypted; //decrypted cypher

	if (argc != 7) {
		printf("Please provide P, Q, E, D, message and encrypted values.");
		return 0;
	}

	P = atoi(argv[1]); //first prime
	Q = atoi(argv[2]); //second prime
	E = atoi(argv[3]); //public exponent
	D = atoi(argv[4]); //private exponent

	message = atoi(argv[5]); //encrypted plaintext
	encrypted = atoi(argv[6]); //decrypted cypher

	ulli* encrypt_test_mm = ME_MMM(message, e, m);
	if (encrypted != encrypt_test_mm) {
		printf("Failed encryption on test %i!\n", i);
		printf("Expected: %i\nActual: %i\n", encrypted, encrypt_test_mm);
		return 0;
	} else {
		printf("MMM encrypted successfully!\n");
	}

	ulli* decrypt_test_mm = ME_MMM(encrypted, d, m);
	if (message != decrypt_test_mm) {
		printf("Failed decryption on test %i!\n", i);
		printf("Expected: %i\nActual: %i\n", message, decrypt_test_mm);
		return 0;
	} else {
		printf("MMM decrypted successfully!\n");
	}
	return 1;
}