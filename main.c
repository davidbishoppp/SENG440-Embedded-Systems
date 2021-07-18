#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RSA.h"

#define NUM_TESTS 10
#define CSV_PATH "./generator/key_value.csv"

struct key_value {
	int p;
	int q;
	int e;
	int d;
	int message;
	int encrypted;
};

struct key_value* loadCSV(char* path) {
	struct key_value* tests = malloc(sizeof(struct key_value) * NUM_TESTS);

	char line[1024];
	FILE* stream = fopen(path, "r");
	int i = 0;
	fgets(line, 1024, stream); // Skip the header line
	while (fgets(line, 1024, stream) && i < NUM_TESTS) {
		struct key_value* test = malloc(sizeof(struct key_value));
		char* delim = ",";
		test->p = atoi(strtok(line, delim));
		test->q = atoi(strtok(NULL, delim));
		test->e = atoi(strtok(NULL, delim));
		test->d = atoi(strtok(NULL, delim));
		test->message = atoi(strtok(NULL, delim));
		test->encrypted = atoi(strtok(NULL, delim));
		tests[i] = *test;
		free(test);
		i++;
	}

	return tests;
}

int main(int argc, char* argv[]) {
	struct key_value* tests = loadCSV(CSV_PATH);

	printf("--- Starting RSA Encryption/Decryption Tests ---\n");

	int p;
	int q;
	int m;
	int e;
	int d;
	int message;
	int encrypted;
	for (int i = 0; i < NUM_TESTS; i++) {
		p = tests[i].p;
		q = tests[i].q;
		m = p*q;
		e = tests[i].e;
		d = tests[i].d;
		message = tests[i].message;
		encrypted = tests[i].encrypted;
		
		printf("--- Test %i ---\n", i);
		printf("p - %i\n", p);
		printf("q - %i\n", q);
		printf("m - %i\n", m);
		printf("e - %i\n", e);
		printf("d - %i\n", d);
		printf("message - %i\n", message);
		printf("encrypted - %i\n", encrypted);

		int encrypt_test_mm = ME_MMM(message, e, m);
		if (encrypted != encrypt_test_mm) {
			printf("Failed encryption on test %i!\n", i);
			printf("Expected: %i\nActual: %i\n", encrypted, encrypt_test_mm);
		} else {
			printf("MMM encrypted successfully!\n");
		}

		int decrypt_test_mm = ME_MMM(encrypted, d, m);
		if (message != decrypt_test_mm) {
			printf("Failed decryption on test %i!\n", i);
			printf("Expected: %i\nActual: %i\n", message, decrypt_test_mm);
		} else {
			printf("MMM decrypted successfully!\n");
		}
	}
	return 1;
}