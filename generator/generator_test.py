import random, sys, os

def gcd(a, b):
    # Return the GCD of a and b using Euclid's Algorithm
    while a != 0:
        a, b = b % a, a
    return b


def findModInverse(a, m):
    # Returns the modular inverse of a % m, which is
    # the number x such that a*x % m = 1

    if gcd(a, m) != 1:
        return None # no mod inverse if a & m aren't relatively prime

    # Calculate using the Extended Euclidean Algorithm:
    u1, u2, u3 = 1, 0, a
    v1, v2, v3 = 0, 1, m
    while v3 != 0:
        q = u3 // v3 # // is the integer division operator
        v1, v2, v3, u1, u2, u3 = (u1 - q * v1), (u2 - q * v2), (u3 - q * v3), v1, v2, v3
    return u1 % m

def main():
	makeKeyFiles('RSA_demo', 1024)

def generateKey(keySize):
	# Step 1: Create two prime numbers, p and q. Calculate n = p * q.
	p = 961748941
	q = 982451653
	n = p * q

	# Step 2: Create a number e that is relatively prime to (p-1)*(q-1).
	print('Generating e that is relatively prime to (p-1)*(q-1)...')
	while True:
		e = random.randrange(2 ** (keySize - 1), 2 ** (keySize))
		if gcd(e, (p - 1) * (q - 1)) == 1:
			break

	# Step 3: Calculate d, the mod inverse of e.
	print('Calculating d that is mod inverse of e...')
	d = findModInverse(e, (p - 1) * (q - 1))
	publicKey = (n, e)
	privateKey = (n, d)
	print('Public key:', publicKey)
	print('Private key:', privateKey)
	return (publicKey, privateKey)

def makeKeyFiles(name, keySize):
	# Creates two files 'x_pubkey.txt' and 'x_privkey.txt' (where x is the value in name) with the the n,e and d,e integers written in them, delimited by a comma.
	if os.path.exists('%s_pubkey.txt' % (name)) or os.path.exists('%s_privkey.txt' % (name)):
		sys.exit('WARNING: The file %s_pubkey.txt or %s_privkey.txt already exists! Use a different name or delete these files and re-run this program.' % (name, name))
	publicKey, privateKey = generateKey(keySize)
	print()
	print('The public key is a %s and a %s digit number.' % (len(str(publicKey[0])), len(str(publicKey[1])))) 
	print('Writing public key to file %s_pubkey.txt...' % (name))

	fo = open('%s_pubkey.txt' % (name), 'w')
	fo.write('%s,%s,%s' % (keySize, publicKey[0], publicKey[1]))
	fo.close()
	print()
	print('The private key is a %s and a %s digit number.' % (len(str(publicKey[0])), len(str(publicKey[1]))))
	print('Writing private key to file %s_privkey.txt...' % (name))

	fo = open('%s_privkey.txt' % (name), 'w')
	fo.write('%s,%s,%s' % (keySize, privateKey[0], privateKey[1]))
	fo.close()
	# If makeRsaKeys.py is run (instead of imported as a module) call
	# the main() function.
if __name__ == '__main__':
	main()