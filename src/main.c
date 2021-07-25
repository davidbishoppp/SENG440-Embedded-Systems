#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

	char line[LENGTH_BYTES];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	while (fgets(line, LENGTH_BYTES, stream)) {
		printf("%s\n", line);
		copyStr(message, line);
		ulli encrypted[2] = {0LLU, 0LLU};
		ME_MMM(message, E, M, encrypted);

		ulli decrypted[2] = {0LLU, 0LLU};
		ME_MMM(encrypted, D, M, decrypted);
		if (!equal(message, decrypted)) {
			printUlli(message, "Message");
			printUlli(encrypted, "Encrypted");
			printUlli(decrypted, "Decrypted");
			return 1;
		} else {
			printf("MMM decrypted successfully!\n");
		}
	}
	return 1;
}