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
	ulli M[2] = {0LLU, 943997864817796661}; // 944871836856449473 = 0xD1CDBEDF21979C1
	ulli R2[2] = {0LLU, 58372345598942367}; //(1<<12) << 1 = 16777216 mod 3233 = 1179
	ulli E[2] = {0LLU, 535447308525948791}; // 288944436900192587 = 0x402896F3942E14B
	ulli D[2] = {0LLU, 809798858682407111}; // 931743036858455603 = 0xCEE375AFDE45633

	// ulli M[2] = {0LLU, 3233LLU}; // 944871836856449473 = 0xD1CDBEDF21979C1
	// ulli R2[2] = {0LLU, 1179LLU}; // (1<<12) << 1 = 16777216 mod 3233 = 1179
	// ulli E[2] = {0LLU, 17LLU}; // 288944436900192587 = 0x402896F3942E14B
	// ulli D[2] = {0LLU, 2753LLU}; // 931743036858455603 = 0xCEE375AFDE45633

	ulli message[LENGTH];

	unsigned int length = 1 + 1;
	char line[length];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	while (fgets(line, length, stream)) {
		fprintf(stderr, "Line: %s\n", line);

		message[LOW] = 0LLU;
		message[HIGH] = 0LLU;
		copyStr(message, line);

		ulli* encrypted = ME_MMM(message, E, M, R2);

		ulli* decrypted = ME_MMM(encrypted, D, M, R2);

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