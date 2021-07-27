#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "RSA.h"

#define MESSAGE_PATH "./message.txt"
#define LENGTH_BYTES 16

int main(int argc, char* argv[]) {
	// Example values from slides.
	//ulli P[2] = {0LLU, 61LLU};
	//ulli Q[2] = {0LLU, 53LLU};
	ulli M[2] = {0LLU, 3233LLU};

	ulli E[2] = {0LLU, 17LLU};
	ulli D[2] = {0LLU, 2753LLU};

	ulli message[LENGTH];

	unsigned int length = floor(bitLength(M)/8) + 1;
	char line[length];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	while (fgets(line, length, stream)) {
		fprintf(stderr, "Line: %s\n", line);

		message[LOW] = 0LLU;
		message[HIGH] = 0LLU;
		copyStr(message, line);

		ulli* encrypted = ME_MMM(message, E, M);

		ulli* decrypted = ME_MMM(encrypted, D, M);

		printUlli(message, "Message");
		printUlli(encrypted, "Encrypted");
		printUlli(decrypted, "Decrypted");

		if (!equal(message, decrypted) || zero(message) || zero(encrypted) || zero(decrypted)) {
			printf("MMM DID NOT encrypt successfully!\n");
			free(encrypted);
			free(decrypted);
			return 1;
		} else {
			printf("MMM decrypted successfully!\n");
		}
		free(encrypted);
		free(decrypted);
	}

	return 1;
}