all: compile

compile:
	gcc -Wall ./src/main.c -o main

clean: 
	-rm -f main
