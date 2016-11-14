#!/bin/bash
source ../build.sh
timer ../results.csv lua lpeg fieldcount "./csv.lua < /tmp/hello.csv"
timer ../results.csv lua lpeg empty "./csv.lua < /tmp/empty.csv"
