all: compile

compile:
	gcc -Wall main.c -o main.so

clean: 
	-rm -f main
