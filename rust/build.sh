#!/bin/bash
for SCRIPT in csvreader libcsv-reader quick-reader; do 
  echo $SCRIPT
  pushd $SCRIPT
  cargo build --release
  for i in $(seq 1 10); do 
    time ./target/release/$SCRIPT /tmp/hello.csv
  done
  popd
done
