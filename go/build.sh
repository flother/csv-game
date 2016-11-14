#!/bin/bash
source  ../build.sh
(cd csv && go build -o csv)
timer ../results.csv golang csv fieldcount "./csv/csv < /tmp/hello.csv"
timer ../results.csv golang csv empty "./csv/csv < /tmp/empty.csv"
