#!/bin/bash
(cd csvreader && ocamlbuild -package csv csvreader.native)
TIMEFORMAT='ocaml,csv,%R'
for i in $(seq 1 10); do 
    (time ./csvreader/csvreader.native < /tmp/hello.csv) 2>> ../results.csv
done
