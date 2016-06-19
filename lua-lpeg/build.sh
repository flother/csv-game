#!/bin/bash
luarocks install lpeg
for i in $(seq 1 10); do 
    time ./csv.lua < /tmp/hello.csv
done
