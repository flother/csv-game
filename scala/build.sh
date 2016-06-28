#!/bin/bash

mvn package
bindir=$(realpath $(dirname $0))
csv_path=$bindir/target/scala-csv-1.0-SNAPSHOT-jar-with-dependencies.jar

TIMEFORMAT='scala,MightCsv,%R'
for i in $(seq 1 10); do 
    (time java -cp "${csv_path}" ScalaCsv < /tmp/hello.csv) 2>> ../results.csv
done
