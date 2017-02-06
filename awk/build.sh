#!/bin/bash
source ../build.sh
timer ../results.csv gawk "regexp" fieldcount "gawk -f ./fieldcount.awk /tmp/hello.csv"
timer ../results.csv gawk "regexp" empty "gawk -f ./fieldcount.awk /tmp/empty.csv"
