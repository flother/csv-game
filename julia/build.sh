#!/bin/bash
source ../build.sh
timer ../results.csv julia dataframe fieldcount "./csv.jl < /tmp/hello.csv"
timer ../results.csv julia dataframe empty "./csv.jl < /tmp/empty.csv"
