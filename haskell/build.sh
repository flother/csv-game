#!/bin/bash
ghc Csv.hs
TIMEFORMAT='haskell,cassava,%R'
for i in $(seq 1 10); do 
    (time ./Csv < /tmp/hello.csv) 2>> ../results.csv
done
