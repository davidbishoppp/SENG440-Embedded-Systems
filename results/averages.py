import sys
import math
import csv

with open ("./results.csv", newline='') as file:
    reader = csv.DictReader(file)
    encrypt_total = 0
    encrypt_min = 1
    encrypt_max = 0

    decrypt_total = 0   
    decrypt_min = 1
    decrypt_max = 0

    count = 0

    for row in reader:
        count += 1
        e = float(row['en'])
        d = float(row['de'])

        encrypt_total += e
        decrypt_total += d

        if e > encrypt_max :
            encrypt_max = e
        if e < encrypt_min :
            encrypt_min = e
        if d > decrypt_max :
            decrypt_max = d
        if d < decrypt_min :
            decrypt_min = d

    e_avg = encrypt_total / count
    d_avg = decrypt_total / count
    
    print("encrypt avg: ", e_avg)
    print("decrypt avg: ", d_avg)
    print("min encrypt: ", encrypt_min)
    print("max encrypt: ", encrypt_max)
    print("min decrypt: ", decrypt_min)
    print("min decrypt: ", decrypt_max)
