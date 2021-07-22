#include <stdio.h>

typedef unsigned int u128; // [0] = high bits. [n] = low bits
typedef unsigned long long int ulli;

u128* add(u128* restrict a, u128* restrict b) {
	u128 result[2];
	result[1] = a[1] + b[1];
	if (a[1] > 0 && b[1] > __INT_MAX__ - a[1]) { // Overflow
		result[0] = a[0] + b[0] + 1;
	} else {
		result[0] = a[0] + b[0];
	}
	return result;
}

int main(void) {
	// assign u128
	u128 a[2] = {0, 1};
	u128 b[2] = {0, 1};

	// assign ulli
	ulli aa = 1LL;
	ulli bb = 2LL;

	// add u128
	u128* s = add(a, b);

	// add ulli
	ulli ss = aa + bb;
}