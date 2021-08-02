#include <stdio.h>
#include <arm_neon.h>

volatile uint64x2_t a, b, c;

int main(void) {
	a[0] = 0x10203040;
	a[1] = 0x50607080;
	printf("a: low %llx high: %llx\n", a[0], a[1]);

	a = vrev64q_u32(a);
	printf("a: low %llx high: %llx\n", a[0], a[1]);
}