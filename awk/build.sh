#!/bin/bash
source ../build.sh
timer ../results.csv gawk "regexp" fieldcount "./fieldcount.awk /tmp/hello.csv"
timer ../results.csv mawk "regexp" fieldcount "./fieldcount.awk /tmp/hello.csv"
