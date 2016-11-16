#!/bin/bash
source ../build.sh
for SCRIPT in csvreader libcsv-reader quick-reader peg-reader nom-reader; do 
  echo $SCRIPT
  (cd $SCRIPT && cargo build --release)
done
timer ../results.csv rust csvreader fieldcount "./csvreader/target/release/csvreader /tmp/hello.csv"
timer ../results.csv rust csvreader empty "./csvreader/target/release/csvreader /tmp/empty.csv"
timer ../results.csv rust libcsv-reader fieldcount "./libcsv-reader/target/release/csvreader /tmp/hello.csv"
timer ../results.csv rust libcsv-reader empty "./libcsv-reader/target/release/csvreader /tmp/empty.csv"
timer ../results.csv rust quick-reader fieldcount "./quick-reader/target/release/quick-reader /tmp/hello.csv"
timer ../results.csv rust quick-reader empty "./quick-reader/target/release/quick-reader /tmp/empty.csv"
timer ../results.csv rust peg-reader fieldcount "./peg-reader/target/release/peg-reader /tmp/hello.csv"
timer ../results.csv rust peg-reader empty "./peg-reader/target/release/peg-reader /tmp/empty.csv"
timer ../results.csv rust nom-reader fieldcount "./nom-reader/target/release/nom-reader /tmp/hello.csv"
timer ../results.csv rust nom-reader empty "./nom-reader/target/release/nom-reader /tmp/empty.csv"
