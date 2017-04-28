#!/bin/bash
source ../build.sh
nim compile --define:release csvreader.nim
timer ../results.csv nim parsecsv fieldcount "./csvreader /tmp/hello.csv"
timer ../results.csv nim parsecsv empty "./csvreader /tmp/empty.csv"

