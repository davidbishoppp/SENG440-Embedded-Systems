#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arm_neon.h>

#define LENGTH 2						//standard length of our temp arrays
#define U128_SET    0xffffffffffffffff	//var with all 128 bits set to 1 [used for testing]
#define MSB_LSB_SET 0x8000000000000001	//128-bit MSB and LSB set [used for testing]
#define MSB_SET     0x8000000000000000	//128-bit with MSB set [used for testing]
#define ULL_11      0x1000000000000001	//128-bit with 1 as MS byte and LS byte [used for testing]
#define HIGH 1							//constant to index our length-2 arrays and setting endian
#define LOW 1-HIGH // 0 or 1			//index for low portion of our arrays
#define PRINT_IN_HEX 1


/**
 * Perfoms logical AND bitwise operation on LSB of input using 128-bit NEON registers
 * @param a Input
 * @return LSB of input
 */
static inline uint32_t and_low(uint64x2_t a) {
	return (uint32_t) (a[LOW] & 1);
}

/**
 * Create a new NEON vector from high and low uint64_t variables
 * @param high upper half of 128
 * @param low lower half of 128
 * @return new 128-bit NEON vector
 */
static inline uint64x2_t newU128(uint64_t high, uint64_t low) {
	uint64_t tmp[LENGTH];
	tmp[LOW] = low;
	tmp[HIGH] = high;
	return vld1q_u64(tmp);
}

/**
 * Initialize an empty 128-bit NEON vector as 0.
 * @return new 128-bit NEON vector
 */
static inline uint64x2_t newU128_0() {
	return vmovq_n_u64(0);
}

/**
 * Places provided string into a new 128-bit NEON vector.
 * @param str input string from main.c
 * @return new 128-bit NEON vector
 */
static inline uint64x2_t u128FromChar(char* str) {
	return vreinterpretq_u64_u8(vld1q_s8((const signed char*)str));
}

/**
 * Prints the contents of a 128-bit NEON register
 * @param a the vector to be printed
 * @param label a descriptive label for the print
 */
void printU128(uint64x2_t a, const char* label) {
	if (PRINT_IN_HEX) {
		if (HIGH) {
			fprintf(stderr, "%s - low: 0x%llx high: 0x%llx\n", label, vgetq_lane_u64(a, LOW),vgetq_lane_u64(a, HIGH));	
		} else {
			fprintf(stderr, "%s - high: 0x%llx low: 0x%llx\n", label, vgetq_lane_u64(a, HIGH), vgetq_lane_u64(a, LOW));	
		}
	} else {
		if (HIGH) {
			fprintf(stderr, "%s - low: %llu high: %llu\n", label, vgetq_lane_u64(a, LOW), vgetq_lane_u64(a, HIGH));
		} else {
			fprintf(stderr, "%s - high: %llu low: %llu\n", label, vgetq_lane_u64(a, HIGH), vgetq_lane_u64(a, LOW));
		}
	}
}

/**
 * Perform a bitwise shift of 1 to the right on a 128-bit NEON vector.
 * @param a Operand
 * @return a shifted right by b.
 */
static inline uint64x2_t shiftRight(uint64x2_t a) {
	uint64x2_t tmp = vshrq_n_u64(a, 1);
	if (a[HIGH] & 1) tmp[LOW] |= MSB_SET;
	return tmp;
}

/**
 * Add two 128-bit NEON vectors together with carry.
 * @param a First NEON vector
 * @param b Second NEON vector
 * @return a + b
 */
static inline uint64x2_t add(uint64x2_t a, uint64x2_t b) {
	uint64x2_t tmp = vaddq_u64(a, b); // add
	if (tmp[LOW] < b[LOW]) tmp[HIGH]++;
	return tmp;
}

/**
 * Subtract two 128-bit NEON vectors with carry.
 * @param a First NEON vector
 * @param b Second NEON vector
 * @return a - b
 */
static inline uint64x2_t subtract(uint64x2_t a, uint64x2_t b) {
	uint64x2_t tmp = vsubq_u64(a, b); // subtract
	if (tmp[LOW] > a[LOW]) tmp[HIGH]--;
	return tmp;
}

/**
 * Compares the contents of two 128-bit NEON vectors.
 * @param a First NEON vector
 * @param b Second NEON vector
 * @return a >= b
 */
uint32_t greaterThanEqual(uint64x2_t a, uint64x2_t b) {
	uint64_t a_low = a[LOW];
	uint64_t a_high = a[HIGH];
	uint64_t b_low = a[LOW];
	uint64_t b_high = b[HIGH];
	if ((a_high < b_high) || ((a_high == b_high) && (a_low < b_low))) return 0;
	return 1;
}

/**
 * Compare the contents of two 128-bit NEON vectors
 * @param a First NEON vecotr
 * @param b Second NEON vector
 * @return a == b
 */
uint32_t equal(uint64x2_t a, uint64x2_t b) {
	uint64_t a_low = a[LOW];
	uint64_t a_high = a[HIGH];
	uint64_t b_low = b[LOW];
	uint64_t b_high = b[HIGH];
	if ((a_high == b_high) && (a_low == b_low)) return 1;
	return 0;
}

// [Below is old testing code. Unit test that were used when creating u128.h]

// int main(void) {
// 	uint64x2_t a = newU128(0LLU, MSB_LSB_SET);
// 	uint64x2_t b = newU128(3LLU, MSB_LSB_SET);
// 	uint64x2_t c = newU128(0LLU, MSB_LSB_SET);
// 	uint64x2_t d = newU128(0LLU, MSB_LSB_SET);
// 	uint64x2_t e = newU128(1LLU, ULL_11);

// 	a = shiftLeft(a);
// 	printU128(a, "a"); // expect a - low: 0x2 high: 0x1

// 	b = shiftRight(b);
// 	printU128(b, "b"); // expect b - low: 0xc000000000000000 high: 0x1

// 	uint64x2_t tmp1 = add(c, c);
// 	printU128(tmp1, "tmp1"); // expect tmp1 - low: 0x2 high: 0x1

// 	uint64x2_t tmp2 = subtract(e, e);
// 	printU128(tmp2, "tmp2"); // expect tmp2 - low: 0x0 high: 0x0

// 	int gt = greaterThanEqual(e, d);
// 	printf("greater than: %i.\n", gt); // Expect 0.

// 	int lt = greaterThanEqual(d, e);
// 	printf("less than: %i.\n", lt); // Expect 1.

// 	uint8_t* str = "hello world! ";
// 	uint64x2_t tmp3 = copyStr(str);
// 	printU128(tmp3, "temp"); // Expect temp - low: 0x68656c6c6f20776f high: 0x726c642120000000
// }