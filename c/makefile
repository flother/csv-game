CFLAGS=-Werror -Wall -pedantic -std=c11 -g -O2 -fpic -march=native

.PHONY: all

all: csv csv-count

csv: csv.c
	$(CC) $(CFLAGS) -lcsv $< -o $@

csv-count: csv-count.c
	$(CC) $(CFLAGS) -lcsv $< -o $@

clean: 
	rm csv csv-count
