#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int bitLength(int M) {
	int m = 0;
	int tmp = M;
	// Find actual length of M
	for (int i = 0; i < (sizeof(M) * 8); i++) {
		if (tmp & 1) {
			m = i + 1;
		}
		tmp = tmp >> 1;
	}
	return m;
}

int ME(int X, int E, int M ) {
	int Z = 1;
	int P = X;
	for (int i = 0; i < (sizeof(E) * 8); i++) {
		//printf("ME: P = %i, Z = %i\n", P, Z);
		if  ((E >> i) & 1) {
			Z = (Z*P) % M;
		}
		P = (P*P) % M;
	}
	return Z;
}

int MMM(int X, int Y, int M) {\
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
	for (int i = 0; i < (sizeof(M) * 8); i++) {
		//printf("MMM: P = %i, Z = %i\n", P, Z);
		if  ((E >> i) & 1) {
			Z = (Z*P) % M;
		}
		Xbar = MMM(P, R*R, M);
		Ybar = MMM(P, R*R, M);
		Zbar = MMM(Ybar, Xbar, M);
		P = MMM(Zbar, 1, M);
	}
	return Z;
}



int main(int argc, char* argv[]) {
	if (argc != 7) {
		printf("Need P, Q, E, D and the encripted/dectripted text!\n");
		printf("got:\n");
		for (int i = 0; i < argc; i++) {
			printf("%s\n", argv[i]);
		}
		return 0;
	}

	int P = atoi(argv[1]);
	int Q = atoi(argv[2]);
	int E = atoi(argv[3]);
	int D = atoi(argv[4]);

	int encrypted = atoi(argv[5]);
	int decrypted = atoi(argv[6]);

	int decrypted_encrypted = MEwithMMM(decrypted, E, (P*Q));
	if (encrypted != decrypted_encrypted) {
		printf("Encryption does not match\n");
		printf("%i does not equal %i\n", encrypted, decrypted_encrypted);
		return 0;
	}

	int encrypted_decrypted = MEwithMMM(encrypted, D, (P*Q));
	if (decrypted != encrypted_decrypted) {
		printf("Decryption does not match\n");
		printf("%i does not equal %i\n", decrypted, encrypted_decrypted);
		return 0;
	} 

	printf("works!\n");
	return 1;
}