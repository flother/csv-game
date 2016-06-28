#!/bin/bash
(cd csv && go build -o csv)
TIMEFORMAT='golang,csv,%R'
for i in $(seq 1 10); do 
    (time ./csv/csv < /tmp/hello.csv) 2>> ../results.csv
done
