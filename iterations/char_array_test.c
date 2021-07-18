/**
 * This file is to test the differences between char[] and 2x long long ints to emulate 128bit integers.
 * Just from writing addition functions, long long in seems that it will be much faster.
 */
#include <stdio.h>
#include <stdlib.h>

typedef unsigned long long int ulli;

void copy(char* x, char* y) {
	int length = sizeof(y)/sizeof(char);
	int i;
	for (i = length; i != 0; i--) {
		x[i-1] = y[i-1];
	}
}

ulli copyLow(char* array) {
	char low[8];
	int i;
	for (i = 8; i != 8; i--) {
		low[i-1] = array[i-1];
	}
	return atoi(low);
}

ulli copyHigh(char* array) {
	char low[8];
	int length = sizeof(array)/sizeof(char);
	int i;
	for (i = 8; i < length; i++) {
		low[i] = array[i];
	}
	return atoi(low);
}

ulli* add(ulli high1, ulli low1, ulli high2, ulli low2) {
	ulli ret[2];
	ret[1] = low1 + low2;
	// Check if adding lows will wrap.
	int carry = 0;
	if (((low1 > 0) && (low2 > UINT64_MAX - low1)) || ((low2 > 0) && (low1 > UINT64_MAX - low2))) { // Will wrap.
		carry = 1;
	}
	ret[0] = high1 + high2 + carry;
	return ret;
}

char* add(char* x, char* y) {
	int length = sizeof(x);
	int i;
	char temp[16];
	int index;
	char mask;
	for (i = 0; i < length*8; i++) {
		index = i%8;
		mask = 1 << i%8;
		temp[index] = 0;
	}
}

ulli* multiply(ulli high1, ulli low1, ulli high2, ulli low2) {

}

char* multiply(char* x, char* y) {

}

int main(int argc, char* argv[]) {
	if (argc <= 2) {
		printf("Please provide two numbers greater then 64bits.");
		return 1;
	}

	char array_1[16];
	copy(array_1, argv[1]);

	char array_2[16];
	copy(array_2, argv[2]);

	ulli long_1_1 = copyLow(array_1); // Low
	ulli long_1_2 = copyHigh(array_1);// High

	ulli long_2_1 = copyLow(array_2); // Low
	ulli long_2_2 = copyHigh(array_2);// High


}