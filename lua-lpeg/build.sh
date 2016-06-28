#!/bin/bash
TIMEFORMAT='lua,lpeg,%R'
for i in $(seq 1 10); do 
    (time ./csv.lua < /tmp/hello.csv) 2>> ../results.csv
done
