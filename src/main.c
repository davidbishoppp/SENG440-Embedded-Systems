#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "RSA.h"

#define MESSAGE_PATH "./generator/inputs_new.txt" //path to inputs
#define MAX_MESSAGE 15 //byte size of each input message

int main(int argc, char* argv[]) {
	uint64x2_t message; //variable for the message

	//timing clock varibles
	clock_t encrypt_start, encrypt_end, decrypt_start, decrypt_end, loop_start, loop_end;

	//parse from file
	char line[MAX_MESSAGE];
	FILE* stream = fopen(MESSAGE_PATH, "r");
	FILE* output = fopen("./results/results.csv", "w+");
	fprintf(output, "encrypt,decrypt\n");


	loop_start = clock();
	while (fgets(line, MAX_MESSAGE, stream) != NULL) {
		encrypt_start = 0;
		encrypt_end = 0;
		decrypt_start = 0;
		decrypt_end = 0;

		message = u128FromChar(line);

		//encrypt line
		encrypt_start = clock();
		uint64x2_t encrypted = Encypt(message);
		encrypt_end = clock();

		//decrypt line
		decrypt_start = clock();
		uint64x2_t decrypted = Decrypt(encrypted);
		decrypt_end = clock();

		double encrypt_time = (double)(encrypt_end - encrypt_start) / CLOCKS_PER_SEC;
		double decrypt_time = (double)(decrypt_end - decrypt_start) / CLOCKS_PER_SEC;
		fprintf(output, "%.7f,%.7f\n", encrypt_time, decrypt_time);

		//check process was correct
		if (!equal(message, decrypted)) {
			printf("NOT euqal!\n");
			return 1;
		}
	}
	loop_end = clock();
	fclose(stream);
	fclose(output);

	double loop_time = (double)(loop_end - loop_start) / CLOCKS_PER_SEC;
	printf("loop time: %.20f\n", loop_time);

	return 1;
}