#!/bin/bash
TIMEFORMAT='ruby,csv,%R'
for i in $(seq 1 10); do 
    (time ./csv.rb < /tmp/hello.csv) 2>> ../results.csv
done
