#!/bin/bash
TIMEFORMAT='python3,csv,%R'
for i in $(seq 1 10); do 
    (time ./csvreader.py < /tmp/hello.csv) 2>> ../results.csv
done