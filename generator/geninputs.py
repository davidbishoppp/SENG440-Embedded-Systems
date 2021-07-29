import sys
import random
import math

# how many inputs to create
NUM_INPUTS = 2000

with open("./inputs.txt", "w") as file:
    for x in range(NUM_INPUTS):
        num = random.randint(1, 10000)
        file.write(str(num))
        file.write("\n")
    