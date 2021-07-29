#include <stdio.h>
#include <stdlib.h>
#include "ulli.h"

ulli M[2] = {0LLU, 943997864817796661}; // 944871836856449473 = 0xD1CDBEDF21979C1
ulli R2[2] = {0LLU, 58372345598942367}; //(1<<12) << 1 = 16777216 mod 3233 = 1179
ulli E[2] = {0LLU, 535447308525948791}; // 288944436900192587 = 0x402896F3942E14B
ulli D[2] = {0LLU, 809798858682407111}; // 931743036858455603 = 0xCEE375AFDE45633

// Example values from slides
//ulli P[2] = {0LLU, 61LLU};
//ulli Q[2] = {0LLU, 53LLU};
// ulli M[2] = {0LLU, 3233LLU}; // 944871836856449473 = 0xD1CDBEDF21979C1
// ulli R2[2] = {0LLU, 1179LLU}; // (1<<12) << 1 = 16777216 mod 3233 = 1179
// ulli E[2] = {0LLU, 17LLU}; // 288944436900192587 = 0x402896F3942E14B
// ulli D[2] = {0LLU, 2753LLU}; // 931743036858455603 = 0xCEE375AFDE45633


/**
 * Computes Montgomery Modular Multiplication
 * @param X Operand 1
 * @param Y Operand 2
 * @return = X*Y*R^-1 % M
*/
ulli* MMM(ulli* X, ulli* Y) {
	ulli* Z = newUlli(0);
	ulli* X_local = copyUlli(X);
	ulli* M_local = copyUlli(M);
	int n;
	int i;
	const int length = bitLength(M_local);
	for (i = 0; i < length; i++) {
		n = (Z[LOW] & 1) ^ ((X_local[LOW] & 1) & (Y[LOW] & 1));
		if (n) {
			add(Z, M_local, Z);
		}
		if (X_local[LOW] & 1) {
			add(Z, Y, Z);
		}
		shiftRight(X_local);
		shiftRight(Z);
	}
	// If T >= M
	if (greaterThan(Z, M_local)) {
		subtract(Z, Z, M_local);
	}
	free(X_local);
	free(M_local);
	return Z;
}

/**
 * Computes Montgomery Modular Multiplication without scale factor R^-1
 * @param X Operand 1
 * @param Y Operand 2
 * @return = X*Y mod M
*/
ulli* MMM_without_scale(ulli* X, ulli* Y) {
	ulli* one = newUlli(1);
	ulli* R2_local = copyUlli(R2);
	ulli* X_bar = MMM(X, R2_local);
	ulli* Y_bar = MMM(Y, R2_local);
	ulli* Z_bar = MMM(X_bar, Y_bar);
	ulli* temp = MMM(Z_bar, one);
	
	free(one);
	free(R2_local);
	free(X_bar);
	free(Y_bar);
	free(Z_bar);

	return temp;
}

/**
 * Computes Modular Exponentiation with MMM
 * @param B Base
 * @param Exp Exponent
 * @return = B^E mod M
 */
ulli* ME_MMM(ulli* B, ulli* Exp) {
	ulli* Z = newUlli(1);
	while (Exp[LOW] != 0LLU || Exp[HIGH] != 0LLU) {
		if(Exp[LOW] & 1LLU) {
			Z = MMM_without_scale(B, Z);
		}
		B = MMM_without_scale(B, B);
		shiftRight(Exp);
	}
	return Z;
}

/**
 * Cumputes the encryption of the message with ME_MMM.
 * @param message The message to be encrypted.
 * @return Encytped message.
 */
ulli* Encypt(ulli* message) {
	ulli* E_local = copyUlli(E);
	return ME_MMM(message, E_local);
}

/**
 * Cumputes the decryption of the message with ME_MMM.
 * @param message The message to be encrypted.
 * @return Decrypted message.
 */
ulli* Decrypt(ulli* message) {
	ulli* D_local = copyUlli(D);
	return ME_MMM(message, D_local);
}

// int main(void) {
// 	// Example values from slides.
// 	//ulli P[2] = {0LLU, 61LLU};
// 	//ulli Q[2] = {0LLU, 53LLU};
// 	ulli M[2] = {0LLU, 0xD1CDBEDF21979C1}; // 944871836856449473 = 0xD1CDBEDF21979C1

// 	ulli E[2] = {0LLU, 0x402896F3942E14B}; // 288944436900192587 = 0x402896F3942E14B
// 	ulli D[2] = {0LLU, 0xCEE375AFDE45633}; // 931743036858455603 = 0xCEE375AFDE45633

// 	ulli message[2] = {0LLU, 123LLU};

// 	ulli X[2] = {0LLU, 100LLU};
// 	ulli Y[2] = {0LLU, 863LLU}; // R = (1<<12) % 3233 = 863

// 	ulli* test1 = MMM(X, Y, M);

// 	printUlli(test1, "test1"); // Expect 100.

// 	ulli* test2 = MMM_without_scale(X, Y, M);

// 	printUlli(test2, "test2"); // Expect 2242.

// 	ulli* test3 = ME_MMM(message, E, M);

// 	printUlli(test3, "test3"); // Expect 855.

// 	ulli* test4 = ME_MMM(test3, D, M);

// 	printUlli(test4, "test4"); // Expect 123.
// }