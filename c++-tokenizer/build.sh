#!/bin/bash
make
TIMEFORMAT='c++,tokenizer,%R'
for i in $(seq 1 10); do 
    (time ./csv < /tmp/hello.csv) 2>> ../results.csv
done
