#!/bin/bash
TIMEFORMAT='R,dataframe,%R'
for i in $(seq 1 10); do 
    (time ./csv.R < /tmp/hello.csv) 2>> ../results.csv
done
