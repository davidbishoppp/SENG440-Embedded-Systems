#include <stdio.h>
#include <stdlib.h>
#include "u128.h"

// THIS FILE WAS ONLY USED FOR HARDWARE ASSIST DEMONSTRATION

//desribes one loop iteration inside MMM_1 in a 32-bit context
unsigned int MMM_1_ITERATION(register unsigned int Y, register unsigned int M) {
    unsigned int Z = 0;
    if(Z & 1) {
        Z = (Z + M);
    }
    Z = (Z >> 1);
}