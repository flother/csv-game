#!/bin/bash
TIMEFORMAT='perl,Text::CSV_XS,%R'
for i in $(seq 1 10); do 
    (time ./csv.pl < /tmp/hello.csv) 2>> ../results.csv
done
