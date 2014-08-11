CXXFLAGS=-Werror -Wall -pedantic -std=c++11 -g -O2 -fpic -march=native

.PHONY: all

all: csv

csv: csv.cc
	$(CXX) $(CXXFLAGS) $< -o $@

clean: 
	rm csv
