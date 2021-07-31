import sys
import random
import math
import string

# how many inputs to create
NUM_INPUTS = 2000
MAX_MESSAGE = 15

with open("./inputs.txt", "w+") as file:
	for x in range(NUM_INPUTS):
		message = ''
		for i in range(MAX_MESSAGE):
			message += random.choice(string.ascii_letters)
		file.write(message)
		file.write("\n")
    