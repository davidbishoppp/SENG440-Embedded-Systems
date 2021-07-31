#!/bin/bash

echo "Compiling..."
gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions ./src/main.c -o main
gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions -S ./src/main.c

echo "Running..."
./main

echo "Calculating Results..."
python3 ./results/averages.py