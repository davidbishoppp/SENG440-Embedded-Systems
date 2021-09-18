# SENG440 - 128-Bit RSA Cryptography Implementation

SENG440 - Embedded Systems - Summer 2021

University of Victoria

David Bishop & Ben Austin

## Platform and Usage
For our project, a Raspberry Pi 3 B+ was used as our development and test machine. The Raspberry Pi that was used runs Debian 10.8 on a ARMv7 rev4 (v7l) processor. For compilation, the included Raspbian gcc 8.3.0 compiler was used. To build the project code as tested on the machine, the following commands can be used to generate an executable and associated assembly code:
  
Executable: 
`gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions ./src/main.c -o main` 

Assembly: 
`gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions -S ./src/main.c`

    
 To compile the code into an executable, assembly, and an optimized version use make. Finally, to execute the code against the test bench, simply run `./test.sh`

## Overview
For our term project, we were tasked with researching, implementing, and optimizing the Rivest- Shamir-Adleman (RSA) Cryptography algorithm on a 32-bit ARM processor, by analyzing and improving the implementation’s assembly-level code to reduce operations and leverage optimization techniques to identify bottlenecks and increase overall performance.
