#!/bin/bash
for i in $(seq 1 10); do 
    time ./csv.rb < /tmp/hello.csv
done
