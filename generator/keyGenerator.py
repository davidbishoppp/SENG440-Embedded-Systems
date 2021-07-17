# Writes a number of known RSA key value pairs to a csv file.

import sys
import numpy as np
import pandas as pd
import random
import math

NUM_KEY_VALUES = 100
if len(sys.argv) > 1:
	NUM_KEY_VALUES = int(sys.argv[1])


# load prime numbers from file
primes = []
with open("./primes.txt") as f:
	lines = f.readlines()
	for line in lines:
		primes.append(int(line))
	

def getPrime():
	return primes[random.randint(0, len(primes)-1)]

def factorize(n):
	factors = []
	T = n

	i = 2
	while (T>1) and (i < (math.sqrt(n)+1)):
		while T%i==0:
			T = T/i
			factors.append(i)
		i += 1
	if T>1:
		factors.append(T)

	return factors

def generatePairs():
	p = getPrime()
	q = getPrime()
	n = p*q
	r = (p-1)*(q-1)

	candidates = []
	for i in range(1, 20):
		candidates.append((r*i)+1)

	e = 0
	d = 0
	for candidate in candidates:
		factors = factorize(candidate)
		if len(factors) > 1:
			e = factors[0]
			d = factors[1]
			if e == d:
				continue
			else:
				break
	e = int(e)
	d = int(d)

	message = random.randint(1234, 123456789)

	encoded = pow(message, e, n)
	decoded = pow(encoded, d, n)
	if decoded != message:
		return []

	return [p, q, e, d, message, encoded]

pairs = []
while len(pairs) < NUM_KEY_VALUES:
	ret = generatePairs()
	if not len(ret):
		continue
	pairs.append(ret)

with open("key_value.csv", mode='w+') as f:
	f.write("p,q,e,d,message,encoded\n")
	for pair in pairs:
		for i in range(len(pair)):
			f.write("%i"%pair[i])
			if i != len(pair)-1:
				f.write(",")
		f.write("\n")

