#!/bin/bash
source ../build.sh
timer ../results.csv awk "regexp" fieldcount "./fieldcount.awk /tmp/hello.csv"
