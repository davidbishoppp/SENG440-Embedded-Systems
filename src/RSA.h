#include <stdio.h>
#include <stdlib.h>
#include "u128.h"

// Constants that are used in form of bytes, decimal, and bit length.

// M = 0x3ffffffffffffe59,000000000002b1f1 = 85070591730234608062870908678801895921
#define M_LOW  0x000000000002b1f1
#define M_HIGH 0x3ffffffffffffe59
#define M_BIT_LENGTH 126

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
 * Computes Montgomery Modular Multiplication using two 128-bit NEON vectors.
 * @param X First NEON vector
 * @param Y Second NEON vector
 * @return X*Y*R^-1 % M
*/
uint64x2_t MMM(register uint64x2_t X, register uint64x2_t Y) {
	register uint64x2_t Z = newU128_0(); //initialize Z as 0
	register uint64x2_t M = newU128(M_HIGH, M_LOW); //initialize M based on its high and low bits
	register int i, X1;	//loop variables
	register const int Y1 = and_low(Y); //low bit of Y

	//loop over bit length of M
	for (i = M_BIT_LENGTH; i; i--) {
		X1 = and_low(X); //get LSB of X

		//see if LSB of X and LSB of Y are set, XOR LSB of Z is set.
		if (and_low(Z) ^ (X1 & Y1)) { 
			Z = add(Z, M); //if so, add M to Z
		}

		//if LSB of X is set
		if (X1) {
			Z = add(Z, Y); //add Y to Z
		}

		//shift X and Z right by 1
		X = shiftRight(X);
		Z = shiftRight(Z);
	}
	// If Z >= M
	if (greaterThanEqual(Z, M)) {
		Z = subtract(Z, M); //subtract M from Z
	}

	//return the product of the MMM algorithim
	return Z;
}

/**
 * Computes Montgomery Modular Multiplication with constant 1.
 * This is used because when observing the above MMM method, if we set
 * X = 1, then we can reduce operations significantly by knowing its first bit
 * is 1, and the rest are 0.
 * @param Y First 128-bit NEON vector
 * @return Y*1*R^-1 % M
*/
uint64x2_t MMM_1(register uint64x2_t Y) {
	register uint64x2_t Z = newU128_0(); //initialize Z as 0
	register uint64x2_t M = newU128(M_HIGH, M_LOW); //initialize M from its high and low bits
	register int i; //loop variable

	//knowing Z = 0 and X = 1, we can reduce the if statement from the regular MMM implementation down
	//to simply checking the LSB of Y.
	if (and_low(Y)) {
		Z = add(Z, M);
	}
	Z = add(Z, Y); //add Y to Z because we know LSB of X is set
	Z = shiftRight(Z); //shfit Z right by 1 

	//iterate over bit length of M
	for (i = M_BIT_LENGTH - 1; i; i--) {
		//knowing X is now 0, the if statement can be reduced to only checking the LSB of Z
		if (and_low(Z)) {
			Z = add(Z, M); //add M to Z
		}
		Z = shiftRight(Z); //shfit Z right by 1
	}
	// If Z >= M
	if (greaterThanEqual(Z, M)) {
		Z = subtract(Z, M); //subtract M from Z
	}
	return Z;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param B Base
 * @param Exp Exponent
 * @return B^E mod M
 */
uint64x2_t ME_MMM(register uint64x2_t B, register uint64x2_t Exp) {
	register uint64x2_t Z = newU128_0(); //initalize a NEON vector for Z to 0
	register uint64x2_t R2 = newU128(R2_HIGH, R2_LOW); //pre-computed constant R^2 computed from R

	Z = MMM_1(R2); // Prescale Z: Z = Z*R
	B = MMM(B, R2); // Prescale B: B = B*R

	//while the exponent is not 0
	while (Exp[LOW] || Exp[HIGH]) {
		//check if LSB of exponent is set
		if(and_low(Exp)) {
			Z = MMM(Z, B); //compute MMM of Z and B
		}
		B = MMM(B, B); //compute MMM of B and B
		Exp = shiftRight(Exp); //shift exponent right by 1
	}

	//compute MMM of Z and 1 to finally de-scale the result
	return MMM_1(Z);
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


// [Below is old testing code. Unit tests from developing RSA.h]

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