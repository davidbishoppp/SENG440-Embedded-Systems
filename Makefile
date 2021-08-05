all: compile

compile:
	gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions ./src/main.c -o main
	gcc -Wall -static -mfloat-abi=hard -mfpu=neon -flax-vector-conversions -S ./src/main.c -o main.s

clean: 
	-rm -f main
