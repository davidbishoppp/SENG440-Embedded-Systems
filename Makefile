all: compile

compile:
	gcc -Wall -static ./src/main.c -o main

clean: 
	-rm -f main
