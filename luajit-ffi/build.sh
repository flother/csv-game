#!/bin/bash
source ../build.sh
timer ../results.csv luajit libcsv fieldcount "./csv.lua < /tmp/hello.csv"
timer ../results.csv luajit libcsv empty "./csv.lua < /tmp/empty.csv"
