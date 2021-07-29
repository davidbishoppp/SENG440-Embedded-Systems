all: compile

compile:
	gcc -Wall -static ./src/main.c -o main
	gcc -Wall -static -S ./src/main.c

clean: 
	-rm -f main
