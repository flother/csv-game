#!/bin/bash
source ../build.sh
timer ../results.csv ruby csv fieldcount "./csv.rb < /tmp/hello.csv"
timer ../results.csv ruby csv empty "./csv.rb < /tmp/empty.csv"
