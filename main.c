#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int bitLength(int M) {
	int m = 0;
	int tmp = M;
	// Find actual length of M
	for (int i = 0; i < (sizeof(M) * __CHAR_BIT__); i++) {
		if (tmp & 1) {
			m = i + 1;
		}
		tmp = tmp >> 1;
	}
	return m;
}

// X: data (either decrypted or encrypted int) (base)
// E: public exponent (exponential)
// M: PQ (divisor)
int ME(int X, int E, int M ) {
	int Z = 1;

	X = X % M;

	while(E > 0) {
		// First bit set
		if(E & 1) {
			Z = (Z * X) % M;
		}

		//shift bits by 1 
		E >>= 1;
		X = (X * X) % M;
	}

	return Z;
}

int MMM(int X, int Y, int M) {
	int T = 0;
	int Xi;
	int T0;
	int Y0;
	int n;
	//printf("i | X(i) | n | T\n");
	for (int i = 0; i < bitLength(M); i++) {
		Xi = (X >> i) & 0x1;
		T0 = (T & 0x1);
		Y0 = (Y & 0x1);

		n = T0 ^ (Xi & Y0);
		T = (T + (Xi * Y) + (n * M)) >> 1;
		//printf("%i | %i | %i | %i\n", i, Xi, n, T);
	}
	if (T >= M) {
		T = T - M;
	}
	return T;
}

int MEwithMMM(int X, int E, int M ) {
	int Z = 1;
	int P = X;

	int Xbar;
	int Ybar;
	int Zbar;

	int R = 2 << bitLength(M);
	for (int i = 0; i < (sizeof(M) * __CHAR_BIT__); i++) { //correct
		//printf("MMM: P = %i, Z = %i\n", P, Z);
		if  ((E >> i) & 1) {
			Z = (Z*P) % M;
		}
		Xbar = MMM(P, R*R, M); //somehwere here
		Ybar = MMM(P, R*R, M);
		Zbar = MMM(Ybar, Xbar, M);
		P = MMM(Zbar, 1, M);
	}
	return Z;
}



int main(int argc, char* argv[]) {
	if (argc != 7) {
		printf("Need P, Q, E, D and the encripted/dectripted text!\n");
		printf("Got:\n");
		for (int i = 1; i < argc; i++) {
			printf("%s\n", argv[i]);
		}
		return 0;
	}

	int P = atoi(argv[1]); //first prime
	int Q = atoi(argv[2]); //second prime
	int E = atoi(argv[3]); //public exponent
	int D = atoi(argv[4]); //private exponent

	int encrypted = atoi(argv[5]); //encrypted plaintext
	int decrypted = atoi(argv[6]); //decrypted cypher

	//test ME only
	int enrcypt_test = ME(decrypted, E, (P*Q));
	if (encrypted != enrcypt_test) {
		printf("Encryption does not match\n");
		printf("%i does not equal %i\n", encrypted, enrcypt_test);
		return 0;
	}
	else {
		printf("Encrypted successfully!\n");
	}

	return 0;


	int decrypt_test = MEwithMMM(encrypted, D, (P*Q));
	if (decrypted != decrypt_test) {
		printf("Decryption does not match\n");
		printf("%i does not equal %i\n", decrypted, decrypt_test);
		return 0;
	} 

	printf("works!\n");
	return 1;
}