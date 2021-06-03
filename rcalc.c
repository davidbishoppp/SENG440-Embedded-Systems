#include <stdio.h>

int main() {
	int R = 64;
	int M = 53;
	for (int i = 0; i < 100; i++) {
		if ((R*i) % M == 1) {
			printf("R^-1 is %i\n", i);
			return 0;
		}
	}
	printf("no find.\n");
}