#!/bin/bash
make
for i in $(seq 1 10); do 
    time ./csv < /tmp/hello.csv
done
