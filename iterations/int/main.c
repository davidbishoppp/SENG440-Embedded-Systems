#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RSA_int.h"
#include "math.h"

#define MESSAGE_PATH "../../message.txt"
#define LENGTH_BYTES 5

void copyStr(unsigned int *result, char* str) {
	int length = strlen(str);
	int i;
	for (i = 0; i < strlen(str); i++) {
		*result |= str[i];

		if (i != length - 1) {
			*result <<= 8;
		}
	}
}


int main(int argc, char* argv[]) {
	// Example values from slides.
	//int P[2] = {0LLU, 61LLU};
	//int Q[2] = {0LLU, 53LLU};
	unsigned int M = 3233;

	unsigned int E = 17;
	unsigned int D = 2753;

	unsigned int message;

	unsigned int length = floor(bitLength(M)/8) + 1;

	char line[length];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	while (fgets(line, length, stream)) {
		printf("line: %s\n", line);

		message = 0;
		copyStr(&message, line);

		unsigned int encrypted = ME_MMM(message, E, M);

		unsigned int decrypted = ME_MMM(encrypted, D, M);

		printf("Message: %u\n", message);
		printf("Encrypted: %u\n", encrypted);
		printf("Decrypted: %u\n", decrypted);

		if (message != decrypted || !message || !encrypted || !decrypted) {
			printf("MMM DID NOT decrypt successfully!\n");
			return 1;
		} else {
			printf("MMM decrypted successfully!\n");
		}
	}
	return 1;
}