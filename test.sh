#!/bin/bash

echo "Compiling..."
make

echo "Running..."
./main

echo "Calculating Results..."
python3 ./results/averages.py