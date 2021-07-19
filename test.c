#include <stdio.h>
#include <stdlib.h>

void arrayFunc(int* arg) {
	arg[0] = 7;
	arg[1] = 10;
	printf("arg: 0) %i, 1) %i\n", arg[0], arg[1]);
}

int main() {
	int temp[2] = {4, 5};
	printf("temp before: 0) %i, 1) %i\n", temp[0], temp[1]);
	arrayFunc(temp);
	printf("temp after: 0) %i, 1) %i\n", temp[0], temp[1]);
}