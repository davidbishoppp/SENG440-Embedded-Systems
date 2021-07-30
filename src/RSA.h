#include <stdio.h>
#include <stdlib.h>
#include "u128.h"

/**
 * TODO: Move these to gloabl variables and localize them later?
 */
#define M_LOW 943997864817796661 // 944871836856449473 = 0xD1CDBEDF21979C1
#define BIT_LENGTH 60
#define R_LOW  1152921504606846976
#define R2_LOW 58372345598942367 //(1<<12) << 1 = 16777216 mod 3233 = 1179
#define E_LOW 535447308525948791 // 288944436900192587 = 0x402896F3942E14B
#define D_LOW 809798858682407111 // 931743036858455603 = 0xCEE375AFDE45633

// Example values from slides
//uint64x2_t P[2] = {0LLU, 61LLU};
//uint64x2_t Q[2] = {0LLU, 53LLU};
// uint64x2_t M[2] = {0LLU, 3233LLU}; // 944871836856449473 = 0xD1CDBEDF21979C1
// uint64x2_t R2[2] = {0LLU, 1179LLU}; // (1<<12) << 1 = 16777216 mod 3233 = 1179
// uint64x2_t E[2] = {0LLU, 17LLU}; // 288944436900192587 = 0x402896F3942E14B
// uint64x2_t D[2] = {0LLU, 2753LLU}; // 931743036858455603 = 0xCEE375AFDE45633

/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @return = X*Y*R^-1 % M
*/
uint64x2_t MMM(uint64x2_t X, uint64x2_t Y, uint64x2_t M) {
	register uint64x2_t Z = newU128(0, 0);
	register int n;
	register int i;
	register const int Y1 = and_low(Y);
	// TODO: Load in only important 32bits at a time???
	for (i = 0; i < BIT_LENGTH; i++) {
		n = and_low(Z) ^ (and_low(X) & Y1);
		if (n) {
			Z = add(Z, M);
		}
		if (and_low(X)) {
			Z = add(Z, Y);
		}
		X = shiftRight(X);
		Z = shiftRight(Z);
	}
	// If T >= M
	if (greaterThanEqual(Z, M)) {
		Z = subtract(Z, M);
	}
	return Z;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param B Base
 * @param Exp Exponent
 * @return = B^E mod M
 * TODO: Bring MMM_without_scale into ME_MMM. register each variable
 */
uint64x2_t ME_MMM(uint64x2_t B, uint64x2_t Exp) {
	register uint64x2_t Z = newU128(0, 1);
	register uint64x2_t M = newU128(0, M_LOW);
	register uint64x2_t R2 = newU128(0, R2_LOW);
	register uint64x2_t one = newU128(0, 1);
	register uint64x2_t X_bar_z;
	register uint64x2_t Y_bar_z;
	register uint64x2_t Z_bar_z;
	register uint64x2_t X_bar_b;
	register uint64x2_t Z_bar_b;
	while (vgetq_lane_u64(Exp, LOW) || vgetq_lane_u64(Exp, HIGH)) {
		if(and_low(Exp)) {
			X_bar_z = MMM(B, R2, M);
			Y_bar_z = MMM(Z, R2, M);
			Z_bar_z = MMM(X_bar_z, Y_bar_z, M);
			Z = MMM(Z_bar_z, one, M);
		}
		X_bar_b = MMM(B, R2, M);
		Z_bar_b = MMM(X_bar_b, X_bar_b, M);
		B = MMM(Z_bar_b, one, M);
		Exp = shiftRight(Exp);
	}
	return Z;
}

/**
 * Cumputes the encryption of the message with ME_MMM.
 * @param message The message to be encrypted.
 * @return Encytped message.
 */
uint64x2_t Encypt(uint64x2_t message) {
	return ME_MMM(message, newU128(0, E_LOW));
}

/**
 * Cumputes the decryption of the message with ME_MMM.
 * @param message The message to be encrypted.
 * @return Decrypted message.
 */
uint64x2_t Decrypt(uint64x2_t message) {
	return ME_MMM(message, newU128(0, D_LOW));
}

// int main(void) {
// 	uint64x2_t message = newU128(0, 123);

// 	uint64x2_t X = newU128(0, 100);
// 	uint64x2_t Y = newU128(0, R_LOW); // R = (1<<12) % 3233 = 863
// 	uint64x2_t Y2 = newU128(0, 2); // R = (1<<12) % 3233 = 863

// 	uint64x2_t test1 = MMM(X, Y);
// 	printU128(test1, "test1"); // Expect 100.

// 	uint64x2_t test2 = MMM_without_scale(X, Y2);
// 	printU128(test2, "test2"); // Expect 200.

// 	uint64x2_t test3 = Encypt(message);
// 	printU128(test3, "test3"); // Expect 855.

// 	uint64x2_t test4 = Decrypt(test3);
// 	printU128(test4, "test4"); // Expect 123.
// }