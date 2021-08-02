#include <stdio.h>
#include <stdlib.h>
#include "u128.h"

// M = 0x3ffffffffffffe59,000000000002b1f1 = 85070591730234608062870908678801895921
#define M_LOW  0x000000000002b1f1
#define M_HIGH 0x3ffffffffffffe59
#define M_BIT_LENGTH 126

// R = 0x1a6,fffffffffffd4e0f = 7802972743179140156943
#define R_LOW  0xfffffffffffd4e0f
#define R_HIGH 0x1a6

// R2 = 0x923866d,ffffffe9d4a0ad5d = 2828312318329170184930110813
#define R2_LOW  0xffffffe9d4a0ad5d
#define R2_HIGH 0x923866d

// E = 0x3872d6e33e658f2c,42d225ca1b9ad4e1 = 75033048045587179659324244315139134689
#define E_LOW  0x42d225ca1b9ad4e1
#define E_HIGH 0x3872d6e33e658f2c
#define E_BIT_LENGTH 126

// D = 0x8983c03eb8bcb8f,e9ee53bace3e18a1 = 11424270343935306717864993741128734881
#define D_LOW  0xe9ee53bace3e18a1
#define D_HIGH 0x8983c03eb8bcb8f
#define D_BIT_LENGTH 124

/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @param M Modulo
 * @return = X*Y*R^-1 % M
*/
uint64x2_t MMM(register uint64x2_t X, register uint64x2_t Y, register uint64x2_t M) {
	register uint64x2_t Z = newU128_0();
	register int i, X1;
	register const int Y1 = and_low(Y);
	for (i = M_BIT_LENGTH; i; i--) {
		X1 = and_low(X);
		if (and_low(Z) ^ (X1 & Y1)) {
			Z = add(Z, M);
		}
		if (X1) {
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
 * Computes Montgomery Modular Multiplication with constant 1.
 * @param X Operand 1
 * @param M Modulo
 * @return = X*1*R^-1 % M
*/
uint64x2_t MMM_1(register uint64x2_t Y, register uint64x2_t M) {
	register uint64x2_t Z = newU128_0();
	register int i;
	// TODO: Load in only important 32bits at a time???
	if (and_low(Y)) {
		Z = add(Z, M);
	}
	Z = add(Z, Y);
	Z = shiftRight(Z);
	for (i = M_BIT_LENGTH - 1; i; i--) {
		if (and_low(Z)) {
			Z = add(Z, M);
		}
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
 */
uint64x2_t ME_MMM(register uint64x2_t B, register uint64x2_t Exp) {
	register uint64x2_t Z = newU128(0, 1);
	register uint64x2_t M = newU128(M_HIGH, M_LOW);
	register uint64x2_t R2 = newU128(R2_HIGH, R2_LOW);
	register uint64x2_t X_bar_z, Y_bar_z, Z_bar_z, X_bar_b, Z_bar_b;

	while (Exp[LOW] || Exp[HIGH]) {
		X_bar_b = MMM(B, R2, M);
		Z_bar_b = MMM(X_bar_b, X_bar_b, M);
		if(and_low(Exp)) {
			X_bar_z = MMM(B, R2, M);
			Y_bar_z = MMM(Z, R2, M);
			Z_bar_z = MMM(X_bar_z, Y_bar_z, M);
			Z = MMM_1(Z_bar_z, M);
		}

		B = MMM_1(Z_bar_b, M);
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
	return ME_MMM(message, newU128(E_HIGH, E_LOW));
}

/**
 * Cumputes the decryption of the message with ME_MMM.
 * @param message The message to be encrypted.
 * @return Decrypted message.
 */
uint64x2_t Decrypt(uint64x2_t message) {
	return ME_MMM(message, newU128(D_HIGH, D_LOW));
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