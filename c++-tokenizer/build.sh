#!/bin/bash
source ../build.sh
make
timer ../results.csv c++ tokenizer fieldcount "./csv < /tmp/hello.csv"
timer ../results.csv c++ tokenizer empty "./csv < /tmp/empty.csv"
