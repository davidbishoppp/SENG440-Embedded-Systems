/**
 * RSA encryption and decryption with ulliegers only.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "RSA_int.h"
#include "math.h"

#define MESSAGE_PATH "../../generator/inputs.txt"
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

<<<<<<< HEAD
	ulli length = 1 + 1;
=======
	//unsigned int length = floor(bitLength(M)/8) + 1;
>>>>>>> 84c705e4773e678fdb3194741d4f4a995b1f2fea

	// clock for timing
	clock_t encrypt_start, encrypt_end, decrypt_start, decrypt_end, loop_start, loop_end;

	char line[5];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	loop_start = clock();
	while (1) {
		encrypt_start = 0;
		encrypt_end = 0;
		decrypt_start = 0;
		decrypt_end = 0;

		if (fgets(line, 6, stream) == NULL) break;
		//printf("line: %s\n", line);

		int temp = 0;
		temp = atoi(line);
		message = 0;
		message = (unsigned int)temp;


<<<<<<< HEAD
		ulli encrypted = ME_MMM(message, E, M);
		printf("end of encrypt\n");
		ulli decrypted = ME_MMM(encrypted, D, M);

		printf("Message: %llu\n", message);
		printf("Encrypted: %llu\n", encrypted);
		printf("Decrypted: %llu\n", decrypted);
=======
		//copyStr(&message, (unsigned int)line);
		encrypt_start = clock();
		unsigned int encrypted = ME_MMM(message, E, M);
		encrypt_end = clock();

		decrypt_start = clock();
		unsigned int decrypted = ME_MMM(encrypted, D, M);
		decrypt_end = clock();

		double encrypt_time = (double)(encrypt_end - encrypt_start) / CLOCKS_PER_SEC;
		double decrypt_time = (double)(decrypt_end - decrypt_start) / CLOCKS_PER_SEC;
		printf("encrypt time: %.7f\n", encrypt_time);
		printf("decrypt time: %.7f\n", decrypt_time);

		//printf("Message: %u\n", message);
		//printf("Encrypted: %u\n", encrypted);
		//printf("Decrypted: %u\n", decrypted);
>>>>>>> 84c705e4773e678fdb3194741d4f4a995b1f2fea

		if (message != decrypted || !message || !encrypted || !decrypted) {
			printf("[ERROR] : MMM did not decrypt successfully!\n");
			return 1;
		} else {
			printf("MMM decrypted successfully!\n");
		}
	}
	loop_end = clock();
	fclose(stream);

	double loop_time = (double)(loop_end - loop_start) / CLOCKS_PER_SEC;
	printf("loop time: %.20f\n", loop_time);
	return 1;
}