#!/bin/bash
for i in $(seq 1 10); do 
    time ./csv.R /tmp/hello.csv
done
