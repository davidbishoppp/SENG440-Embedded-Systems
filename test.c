#include <stdio.h>
#include <stdlib.h>

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')

void arrayFunc(int* arg) {
	arg[0] = 7;
	arg[1] = 10;
	printf("arg: 0) %i, 1) %i\n", arg[0], arg[1]);
}

int main(int argc, char* argv[]) {
	unsigned int i = atoi(argv[1]);
	printf("i: %b\n", i);
	printf("unsigned max int: %u\n", UINT32_MAX);
	for (int i = 0; i < sizeof(argv[1]); i++) {
		printf("Leading text "BYTE_TO_BINARY_PATTERN"\n", BYTE_TO_BINARY(argv[1][i]));
	}
}