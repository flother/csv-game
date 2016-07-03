#!/bin/bash
source ../build.sh
timer ../results.csv python2 csv fieldcount "./csvreader.py < /tmp/hello.csv"
timer ../results.csv python2 csv empty "./csvreader.py < /tmp/empty.csv"
timer ../results.csv python2 pandas fieldcount "./csvreader-pandas.py < /tmp/hello.csv"
timer ../results.csv python2 pandas empty "./csvreader-pandas.py < /tmp/empty.csv"
