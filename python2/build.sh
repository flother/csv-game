#!/bin/bash
for SCRIPT in csvreader.py csvreader-pandas.py ; do 
  TIMEFORMAT="python2,$SCRIPT,%R"
  for i in $(seq 1 10); do 
      (time ./"$SCRIPT" < /tmp/hello.csv) 2>> ../results.csv
  done
done
