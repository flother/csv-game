#!/bin/bash
source ../build.sh
timer ../results.csv python3 csv fieldcount "./csvreader.py < /tmp/hello.csv"
timer ../results.csv python3 csv empty "./csvreader.py < /tmp/empty.csv"
