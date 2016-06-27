#!/bin/bash
TIMEFORMAT='julia,dataframe,%R'
for i in $(seq 1 10); do 
    (time ./csv.jl < /tmp/hello.csv) 2>> ../results.csv
done
