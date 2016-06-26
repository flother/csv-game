#!/bin/bash
(cd csv && go build -o csv)
for i in $(seq 1 10); do 
    time ./csv/csv < /tmp/hello.csv
done
