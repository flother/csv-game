#!/bin/bash
source  ../build.sh
(cd csv && lein uberjar)
cmd="java -jar csv/target/uberjar/csv-0.1.0-SNAPSHOT-standalone.jar"
timer ../results.csv clojure csv fieldcount "$cmd < /tmp/hello.csv"
timer ../results.csv clojure csv empty "$cmd < /tmp/empty.csv"
