#!/bin/bash
source ../build.sh
make
timer ../results.csv c++ spirit fieldcount "./csv < /tmp/hello.csv"
timer ../results.csv c++ spirit empty "./csv < /tmp/empty.csv"
