#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "RSA.h"

#define MESSAGE_PATH "./generator/inputs.txt"
#define LENGTH_BYTES 16

int main(int argc, char* argv[]) {
	// Example values from slides
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

	//timing
	clock_t encrypt_start, encrypt_end, decrypt_start, decrypt_end, loop_start, loop_end;

	char line[10];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	FILE* output = fopen("./results/results.csv", "w+");
	fprintf(output, "en,de\n");
	loop_start = clock();
	while (1) {
		encrypt_start = 0;
		encrypt_end = 0;
		decrypt_start = 0;
		decrypt_end = 0;

		if (fgets(line, 11, stream)  == NULL) break;
		//fprintf(stderr, "Line: %s\n", line);

		message[LOW] = 0LLU;
		message[HIGH] = 0LLU;
		copyStr(message, line);

		encrypt_start = clock();
		ulli* encrypted = ME_MMM(message, E, M, R2);
		encrypt_end = clock();

		decrypt_start = clock();
		ulli* decrypted = ME_MMM(encrypted, D, M, R2);
		decrypt_end = clock();

		double encrypt_time = (double)(encrypt_end - encrypt_start) / CLOCKS_PER_SEC;
		double decrypt_time = (double)(decrypt_end - decrypt_start) / CLOCKS_PER_SEC;
		//printf("encrypt time: %.7f\n", encrypt_time);
		//printf("decrypt time: %.7f\n", decrypt_time);
		fprintf(output, "%.7f,%.7f\n", encrypt_time, decrypt_time);

		//printUlli(message, "Message");
		//printUlli(encrypted, "Encrypted");
		//printUlli(decrypted, "Decrypted");

		if (!equal(message, decrypted) || zero(message) || zero(encrypted) || zero(decrypted)) {
			printf("MMM DID NOT encrypt successfully!\n");
			free(encrypted);
			free(decrypted);
			return 1;
		} else {
			//printf("MMM decrypted successfully!\n");
		}
		free(encrypted);
		free(decrypted);
	}
	loop_end = clock();
	fclose(stream);
	fclose(output);

	double loop_time = (double)(loop_end - loop_start) / CLOCKS_PER_SEC;
	printf("loop time: %.20f\n", loop_time);
	//fprintf(output, "%.20f", loop_time);

	return 1;
}