#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
		//printf("P = %i\n", P);
		if  ((E >> i) & 1) {
			Z = (Z*P) % M;
		}
		P = (P*P) % M;
	}
	return Z;
}

int mmm(int X, int Y, int M) {
	int m = bitLength(M);

	int T = 0;
	for (int i = 0; i < m; i++) {
		int Xi = (X >> i) & 1;
		int T0 = (T & 1);
		int Y0 = (Y & 1);

		int n = T0 ^ (Xi & Y0);
		T = (T + (Xi * Y) + (n * M)) >> 1;
	}
	if (T >= M) {
		T = T - M;
	}
	return T;
}

int MMM(int X, int Y, int M) {
	int m = bitLength(M);

	int R = 2 << m;

	// Prescale
	X = mmm(X, R * R, M);
	Y = mmm(Y, R * R, M);

	int T = 0;
	for (int i = 0; i < m; i++) {
		int Xi = (X >> i) & 1;
		int T0 = (T & 1);
		int Y0 = (Y & 1);

		int n = T0 ^ (Xi & Y0);
		T = (T + (Xi * Y) + (n * M)) >> 1;
	}
	if (T >= M) {
		T = T - M;
	}

	//Unscale
	return mmm(T, 1, M);
}

int MEwithMMM(int X, int E, int M ) {
	int Z = 1;
	int P = X;
	for (int i = 0; i < bitLength(E); i++) {
		//printf("P = %i\n", P);
		if  (((E >> i) & 1) == 1) {
			Z = MMM(Z, P, M);
		}
		P = MMM(P, P, M);
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