import sys
import random
import math

# how many inputs to create
NUM_INPUTS = 50000

with open("./inputs.txt", "w") as file:
    for x in range(NUM_INPUTS):
        num = random.randint(1, 3232)
        file.write(str(num))
        file.write("\n")
    