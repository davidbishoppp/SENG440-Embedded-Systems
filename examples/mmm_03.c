#include <stdio.h>
#include <stdlib.h>

int MMM( int X, int Y, int M, int m) {
  int i;
  int T;
  int Xi, T0, Y0;
  int eta;
  int Xi_Y;
  int eta_M;

  T = 0;
  Y0 = Y & 1;
  for( i=0; i<m; i++) {
    Xi = (X >> i) & 1;
    //printf( "Xi = %i\n", Xi);
    T0 = T & 1;
    //printf( "T0 = %i\n", T0);
    eta = T0 ^ (Xi & Y0);
    //printf( "eta = %i\n", eta);
    Xi_Y = Xi ? Y : 0;
    //printf( "Xi_Y = %i\n", Xi_Y);
    eta_M = eta ? M : 0;
    //printf( "eta_M = %i\n", eta_M);
    T = (T + Xi_Y + eta_M) >> 1;
    //printf( "T = %i\n\n", T);
  }
  while ( T >= M)
    T -= M;

  return T;
}

int main( void) {
  int X;
  int Y;
  int Z;
  int M = 3233;
  int m = 12;
  int R = 863;      // 1 << m = 4096, and 4096 mod 3233 = 863
  int R2 = 1179;    // 863 * 863 mod 3233 = 744769 mod 3233 = 1179
  int R_inv = 1742; // 863 * 1742 mod 3233 = 1
  int reminder_in_C;
  int X_scaled, Y_scaled, Z_scaled;

  printf( "The algorithm configuration is:\n");
  printf( "Bitwidth (m) = %i\n", m);
  printf( "Modulus (M) = %i\n", M);
  printf( "R = %i\t\t[R mod M = (1 << m) mod M = 4096 mod 3233 = 863]\n", R);
  printf( "R^2 = %i\t[R * R mod M = 863 * 863 mod 3233 = 744769 mod 3233 = 1179]\n", R2);
  printf( "R^-1 = %i\t[since R * R^-1 mod M = 863 * 1742 mod 3233 = 1]\n\n", R_inv);

  printf( "Recall that MMM calculates (X * Y * R^-1) mod M.  Let's check that!\n");
  printf( "The range for X and Y is 0...%i. Introduce X and Y below:\n", (1<<m)-1);
  printf( "\tX = ");
  scanf( "%i", &X);
  printf( "\tY = ");
  scanf( "%i", &Y);
  Z = MMM( X, Y, M, m);
  printf( "\tZ = (X * Y * R^-1) mod M = %i\n", Z);
  reminder_in_C = (X * Y * R_inv) % M;
  reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
  printf( "Reminder calculated with the brute force in C:\n\t(X * Y * R^-1) % M = %i\n\n", reminder_in_C);

  printf( "Verify the Identity Operation!\n");
  Z = MMM( R, R, M, m);
  printf( "\tR = MMM( R, R, M, m) = (R * R * R^-1) mod M = %i\n\n", Z);

  printf( "Calculate R_inv.  The easiest way is to use MMM!\n");
  Z = MMM( 1, 1, M, m);
  printf( "\tR_inv = MMM( 1, 1, M, m) = (1 * 1 * R^-1) mod M = %i\n\n", Z);

  printf( "Calculate Z = (X * Y) mod M\n");
  X_scaled = MMM( X, R2, M, m);
  printf( "First, X is scaled up:\n\tX_scaled = MMM( X, R^2, M, m) = %i\n", X_scaled);
  Y_scaled = MMM( Y, R2, M, m);
  printf( "Second, Y is scaled up:\n\tY_scaled = MMM( Y, R^2, M, m) = %i\n", Y_scaled);
  Z_scaled = MMM( X_scaled, Y_scaled, M, m);
  printf( "Third, the scaled up product is calculated:\n\tZ_scaled = MMM( X_scaled, Y_scaled, M, m) = %i\n", Z_scaled);
  Z = MMM( Z_scaled, 1, M, m);
  printf( "Finally, the scaled up product is scaled down:\n\tZ = MMM( Z_scaled, 1, M, m) = %i\n", Z);
  reminder_in_C = (X * Y) % M;
  reminder_in_C = reminder_in_C < 0 ? reminder_in_C + M : reminder_in_C;
  printf( "Reminder calculated with the brute force in C:\n\t(X * Y) % M = %i\n\n", reminder_in_C);
  
  exit( 0);
}

