#!/bin/bash
source ../build.sh
timer ../results.csv php csv fieldcount "./csv.php < /tmp/hello.csv"
timer ../results.csv php csv empty "./csv.php < /tmp/empty.csv"
