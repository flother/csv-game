#!/bin/bash
(cd csv && lein uberjar)
TIMEFORMAT='clojure,csv,%R'
for i in $(seq 1 10) ; do 
    (time java -jar csv/target/uberjar/csv-0.1.0-SNAPSHOT-standalone.jar </tmp/hello.csv) 2>> ../results.csv
done
