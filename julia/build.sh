#!/bin/bash
for i in $(seq 1 10); do 
    time ./csv.jl < /tmp/hello.csv
done
