#!/bin/bash
for SCRIPT in csvreader libcsv-reader quick-reader; do 
  echo $SCRIPT
  TIMEFORMAT="rust,$SCRIPT,%R"
  (cd $SCRIPT && cargo build --release)
  for i in $(seq 1 10); do 
      (time $SCRIPT/target/release/$SCRIPT /tmp/hello.csv) 2>> ../results.csv
  done
done
