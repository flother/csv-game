#!/bin/bash
ghc Csv.hs
for i in $(seq 1 10); do 
    time ./Csv < /tmp/hello.csv
done
