#!/bin/bash
source ../build.sh
timer ../results.csv R dataframe fieldcount "./csv.R < /tmp/hello.csv"
timer ../results.csv R dataframe empty "./csv.R < /tmp/empty.csv"
