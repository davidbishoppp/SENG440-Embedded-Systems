all: compile

compile:
	gcc -Wall -static ./src/main.c -o main
	gcc -S ./src/main.c

asm:
	gcc -S ./src/main.c

clean: 
	-rm -f main
