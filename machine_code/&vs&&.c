#include <stdio.h>

int and(int a, int b) {
	return a&b;
}

int andand(int a, int b) {
	return a && b;
}

int main(void) {
	int a = 1;
	int b = 2;

	int s1 = and(a, b);

	int s2 = andand(a, b);

	return 1;
}