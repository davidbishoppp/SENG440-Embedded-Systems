all: compile

compile:
	gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions ./src/main.c -o main
	gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions -O3 -S ./src/main.c -o main-O3.s
	gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions -S ./src/main.c

clean: 
	-rm -f main
