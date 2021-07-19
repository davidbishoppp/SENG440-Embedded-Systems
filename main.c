#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "RSA.h"
#include "ulli.h"

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

char*** loadCSV(char* path) {
	char*** tests = malloc(sizeof(char) * NUM_TESTS * 1024);

	char line[1024];
	FILE* stream = fopen(path, "r");
	int i = 0; // Each test.
	int j = 0; // Each entry in each test.
	fgets(line, 1024, stream); // Skip the header line
	while (fgets(line, 1024, stream) || i < NUM_TESTS) {
		char** test = malloc(sizeof(char) * 1024);
		char* delim = ",";
		test[0] = strtok(line, delim); // p
		test[1] = strtok(NULL, delim); // q
		test[2] = strtok(NULL, delim); // e
		test[3] = strtok(NULL, delim); // d
		test[4] = strtok(NULL, delim); // message
		test[5] = strtok(NULL, delim); // encrypted
		tests[i] = *test;
		i++;
	}

	return tests;
}

int main(int argc, char* argv[]) {
	char*** tests = loadCSV(CSV_PATH);

	printf("--- Starting RSA Encryption/Decryption Tests ---\n");

	int base = 10;
	ulli* p;
	ulli* q;
	ulli* m;
	ulli* e;
	ulli* d;
	ulli* message;
	ulli* encrypted;
	for (int i = 0; i < NUM_TESTS; i++) {
		p = tests[i];
		q = tests[i];
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