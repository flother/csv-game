#!/bin/bash
TIMEFORMAT='php,csv,%R'
for i in $(seq 1 10); do 
    (time ./csv.php < /tmp/hello.csv) 2>> ../results.csv
done
