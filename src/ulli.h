#include <stdio.h>
#include <string.h>

#define LENGTH 2
#define ULL_MSB_LSB_SET 0x8000000000000001
#define ULL_MSB_SET     0x8000000000000000
#define ULL_11          0x1000000000000001
#define HIGH 0
#define LOW 1-HIGH // 0 or 1

#define PRINT_IN_HEX 0

/**
 * ulli arrays: x[HIGH] = high bits, x[LOW] = low bits 
 */
typedef unsigned long long int ulli; // 64bits (2 registers)

/**
 * Make a new ulli from n.
 */
ulli* newUlli(int n) {
	ulli* temp = malloc(sizeof(ulli) * LENGTH);
	temp[LOW] = (ulli) n;
	temp[HIGH] = 0LLU;
	return temp;
}

/**
 * Copy a ulli from a.
 */
ulli* copyUlli(ulli* a) {
	ulli* temp = malloc(sizeof(ulli) * LENGTH);
	temp[LOW] = a[LOW];
	temp[HIGH] = a[HIGH];
	return temp;
}

/**
 * Print ulli.
 */
void printUlli(ulli* a, char* name) {
	if (PRINT_IN_HEX) {
		fprintf(stderr, "%s: 0x%llx 0x%llx\n", name, a[HIGH], a[LOW]);
	} else {
		fprintf(stderr, "%s: %llu %llu\n", name, a[HIGH], a[LOW]);
	}
}

/**
 * Asses if the ulli is 0.
 */
static inline int zero(ulli* a) {
	return (a[HIGH] == 0LLU && a[LOW] == 0LLU);
}

/**
 * Bit shift right a 128bit number through ulli.
 * 
 * @param x Operand
 */
void shiftRight(ulli* x) {
	int underflow = x[HIGH] & 1;
	x[LOW] >>= 1; // Shift low
	x[HIGH] >>= 1; // Shift high
	if (underflow) {
		x[LOW] |= ULL_MSB_SET;
	}
}

/**
 * Bit shift left a 128bit number through ulli.
 * 
 * @param x Operand
 */
void shiftLeft(ulli* x) {
	ulli carry = x[LOW] & ULL_MSB_SET;
	x[HIGH] <<= 1;
	x[LOW] <<= 1;
	if (carry) {
		x[HIGH] |= 1;
	}
}

/**
 * Add two 128bit numbers through ulli.
 * 
 * @param result = x + y
 * @param x Operand 1
 * @param y Operand 2
 */
void add(ulli* result, ulli* x, ulli* y) {
	int carry = 0;
	if (((x[LOW] > 1) && (y[LOW] > __UINT64_MAX__ - x[LOW]))) { // Will wrap.
		carry = 1;
	}

	result[LOW] = x[LOW] + y[LOW]; // Add low bits.
	result[HIGH] = x[HIGH] + y[HIGH] + carry; // Add high bits.
}

/**
 * Subtract two 128bit numbers through ulli.
 * 
 * @param result x - y
 * @param x Operand 1
 * @param y Operand 2
 */
void subtract(ulli* result, ulli* x, ulli* y) {
	ulli* x_local = copyUlli(x);

	ulli* y_local = copyUlli(y);

	result[LOW] = x_local[LOW] - y_local[LOW];

	result[HIGH] = x_local[HIGH] - y_local[HIGH] - (result[LOW] > x_local[LOW]); // Carry
	
	free(x_local);
	free(y_local);
}

/**
 * Bit length of a 128bit number through ulli.
 * 
 * @param x Operand
 */
int bitLength(ulli* x) {
	int count;
	ulli tmp;
	if (x[HIGH] != 0) {
		tmp = x[HIGH];
		count = 64;
	} else {
		tmp = x[LOW];
		count = 0;
	}
	while(tmp != 0) {
			count++;
			tmp >>= 1;
		}
	return count;
}

/**
 * See if two 128bit numbers are equal.
 */
int equal(ulli* a, ulli* b) {
	if (a[HIGH] == b[HIGH] && a[LOW] == b[LOW]) {
		return 1;
	}
	return 0;
}

/**
 * a > b
 */
int greaterThan(ulli* a, ulli* b) {
	if (a[HIGH] > b[HIGH]) {
		return 1;
	} else {
		if (a[HIGH] == b[HIGH] && a[LOW] > b[LOW]) {
			return 1;
		} else {
			return 0;
		}
	}
}

/**
 * Copy char array of 16 bytes into ulli.
 */
void copyStr(ulli* result, char* str) {
	int length = strlen(str);
	int i;
	int j;
	for (i = 0; i < length; i++) {
		result[LOW] |= str[i];
		if (i != length -1) {
			for (j = 0; j < 8; j++) {
				shiftLeft(result);
			}
		}
	}
}

/**
 * Modulo operation.
 */
void mod(ulli* result, ulli* x, ulli* m) {
	if (greaterThan(m, x)) {
		result[LOW] = x[LOW];
		result[HIGH] = x[HIGH];
		return;
	} else if (equal(x, m)) {
		result[LOW] = 0LLU;
		result[HIGH] = 0LLU;
	}

	result[LOW] = x[LOW];
	result[HIGH] = x[HIGH];

	ulli m_local[2];
	ulli m_prev[2];
	while (greaterThan(result, m)) {
		m_local[LOW] = m[LOW];
		m_local[HIGH] = m[HIGH];

		do  {
			m_prev[LOW] = m_local[LOW];
			m_prev[HIGH] = m_local[HIGH];

			shiftLeft(m_local);
		} while (greaterThan(result, m_local) && greaterThan(m_local, m_prev));

		subtract(result, result, m_prev);
	}
}

// int main(void) {
// 	ulli a[2] = {0LLU, ULL_MSB_LSB_SET};
// 	ulli b[2] = {3LLU, ULL_MSB_LSB_SET};
// 	ulli c[2] = {0LLU, ULL_MSB_LSB_SET};
// 	ulli d[2] = {0LLU, ULL_MSB_LSB_SET};
// 	ulli e[2] = {1LLU, ULL_11};

// 	shiftLeft(a);
// 	printUlli(a, "a");

// 	shiftRight(b);
// 	printUlli(b, "b");

// 	add(c, c, d);
// 	printUlli(c, "c");

// 	subtract(e, e, d);
// 	printUlli(e, "e");

// 	int n = bitLength(d);
// 	printf("bit length of d: %i.\n", n);

// 	int eq = equal(d, d);
// 	printf("equal: %i.\n", eq);

// 	ulli temp[2] = {1LLU, 2LLU};
// 	int not_equal = equal(d, temp);
// 	printf("not equal: %i.\n", not_equal);

// 	int gt = greaterThan(d, e);
// 	printf("greater than: %i.\n", gt);

// 	int lt = greaterThan(e, d);
// 	printf("less than: %i.\n", lt);

// 	char* str = "hello world! hi!";
// 	temp[0] = 0LLU;
// 	temp[1] = 0LLU;
// 	copyStr(temp, str);
// 	printUlli(temp, "temp");

// 	ulli f[2] = {ULL_MSB_LSB_SET, ULL_MSB_LSB_SET};
// 	ulli m[2] = {0LLU, 3233LLU};
// 	mod(f, f, m);
// 	printUlli(f, "f");
// }