#include <stdio.h>
#include "../u128.h"

typedef unsigned long long int ulli;

void addUlli(ulli* result, ulli* a, ulli* b) {
	__asm__("adds %0, %1, %2;" : "=r" (result[0]) : "r" (a[0]), "r" (b[0]));
	__asm__("adc %0, %1, %2;" : "=r" (result[1]) : "r" (a[1]), "r" (b[1]));
}




int main(void) {
	u128 a[4] = {0, 1};
	u128 b[4] = {0, 1};

	ulli aa[2] = {1LLU, 0LLU};
	ulli bb[2] = {0LLU, 1LLU};

	u128 s[4];
	add(s, a, b);

	ulli ss[2] = {0, 0};
	addUlli(ss, aa, bb);

	printf("s: %i %i %i %i\n", s[0], s[1], s[2], s[3]);
	printf("ss: %i %i\n", ss[0], ss[1]);
	return 1;
}