#!/bin/bash
for i in $(seq 1 10); do 
    time ./csvreader.py < /tmp/hello.csv
done
