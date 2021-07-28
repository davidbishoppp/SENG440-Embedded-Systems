/**
 * RSA encryption and decryption with ulliegers only.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RSA_int.h"
#include "math.h"

#define MESSAGE_PATH "../../message.txt"
#define LENGTH_BYTES 5

void copyStr(ulli *result, char* str) {
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
	ulli M = 943997864817796661;

	ulli E = 535447308525948791;
	ulli D = 809798858682407111;

	ulli message;

	ulli length = 1 + 1;

	char line[length];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	while (fgets(line, length, stream)) {
		printf("line: %s\n", line);

		message = 0;
		copyStr(&message, line);

		ulli encrypted = ME_MMM(message, E, M);
		printf("end of encrypt\n");
		ulli decrypted = ME_MMM(encrypted, D, M);

		printf("Message: %llu\n", message);
		printf("Encrypted: %llu\n", encrypted);
		printf("Decrypted: %llu\n", decrypted);

		if (message != decrypted || !message || !encrypted || !decrypted) {
			printf("MMM DID NOT decrypt successfully!\n");
			return 1;
		} else {
			printf("MMM decrypted successfully!\n");
		}
	}
	return 1;
}