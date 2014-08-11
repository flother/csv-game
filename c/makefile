CFLAGS=-Werror -Wall -pedantic -std=c11 -g -O2 -fpic -march=native

.PHONY: all

all: csv

csv: csv.c
	$(CC) $(CFLAGS) -lcsv $< -o $@

clean: 
	rm csv
