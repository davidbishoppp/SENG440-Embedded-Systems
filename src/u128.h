#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arm_neon.h>

#define LENGTH 2
#define MSB_LSB_SET 0x8000000000000001
#define MSB_SET     0x8000000000000000
#define ULL_11          0x1000000000000001
#define HIGH 1
#define LOW 1-HIGH // 0 or 1

#define PRINT_IN_HEX 1

// TODO: Replace all a[LOW] etc with vget_lane_....

static inline uint32_t and_low(uint64x2_t a) {
	return (uint32_t) (vgetq_lane_u64(a, LOW) & 1);
}

/**
 * Make a new ulli from n.
 */
static inline uint64x2_t newU128(uint64_t high, uint64_t low) {
	uint64_t tmp[LENGTH];
	tmp[LOW] = low;
	tmp[HIGH] = high;
	return vld1q_u64(tmp);
}

/**
 * Print ulli.
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
 * Bit shift right a 128bit number through ulli.
 * 
 * @param a Operand
 * @param b Number to shift by.
 * @return a shifted right by b.
 */
uint64x2_t shiftRight(uint64x2_t a) {
	int carry = 0;
	if (a[HIGH] & 1) carry = 1;
	uint64x2_t tmp = vshrq_n_u64(a, 1);
	if (carry) {
		tmp[LOW] |= MSB_SET;
	}
	return tmp;
}

/**
 * Bit shift left a 128bit number through ulli.
* 
 * @param a Operand.
 * @param b Number to shift by.
 * @return a shifted left by b.
 */
uint64x2_t shiftLeft(uint64x2_t a) {
	int carry = 0;
	if (a[LOW] & MSB_SET) carry = 1;
	uint64x2_t tmp = vshlq_n_u64(a, 1);
	if (carry) {
		tmp[HIGH] |= 1;
	}
	return tmp;
}

/**
 * Add two 128bit numbers through ulli.
 * 
 * @param a Operand 1
 * @param b Operand 2
 * @return a + b
 */
uint64x2_t add(uint64x2_t a, uint64x2_t b) {
	uint64_t before = b[LOW]; // Before
	
	uint64x2_t tmp = vaddq_u64(a, b); // add

	uint64_t after = tmp[LOW]; // After

	if (after < before) { // Carry
		tmp[HIGH]++;
	}
	return tmp;
}

/**
 * Subtract two 128bit numbers through ulli.
 * 
 * @param a Operand 1.
 * @param b Operand 2.
 * @return a - b
 */
uint64x2_t subtract(uint64x2_t a, uint64x2_t b) {
	uint64x2_t tmp = vsubq_u64(a, b); // subtract

	uint64_t result[2];
	vst1q_u64(result, tmp); // Store result.

	uint64_t before[2];
	vst1q_u64(before, a); // Store before value.

	if (result[LOW] > before[LOW]) { // Underflow.
		result[HIGH]--;
		return vld1q_u64(result);
	}
	return tmp;
}

/**
 * a > b
 */
uint32_t greaterThanEqual(uint64x2_t a, uint64x2_t b) {
	uint64_t a_low = vgetq_lane_u64(a, LOW);
	uint64_t a_high = vgetq_lane_u64(a, HIGH);
	uint64_t b_low = vgetq_lane_u64(b, LOW);
	uint64_t b_high = vgetq_lane_u64(b, HIGH);
	if ((a_high > b_high) || ((a_high == b_high) && (a_low > b_low))) return 1;
	return 0;
}

/**
 * a > b
 */
uint32_t equal(uint64x2_t a, uint64x2_t b) {
	uint64_t a_low = vgetq_lane_u64(a, LOW);
	uint64_t a_high = vgetq_lane_u64(a, HIGH);
	uint64_t b_low = vgetq_lane_u64(b, LOW);
	uint64_t b_high = vgetq_lane_u64(b, HIGH);
	if ((a_high == b_high) && (a_low == b_low)) return 1;
	return 0;
}

/**
 * Copy uint8_t array into uint64x2_t.
 */
uint64x2_t copyStr(const uint8_t* str) {
	return newU128(0, atoll(str));
}

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