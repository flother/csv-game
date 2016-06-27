#!/bin/bash
mvn package
for SCRIPT in BeanIOCsv CommonsCsv CSVeedCsv JavaCsv OpenCsv UnivocityCsv; do 
  echo $SCRIPT
  TIMEFORMAT="java,$SCRIPT,%R"
  for i in $(seq 1 10); do 
    (time ./$SCRIPT < /tmp/hello.csv) 2>> ../results.csv
  done
done
