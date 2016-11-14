#!/bin/bash
source ../build.sh
timer ../results.csv perl "Text::CSV_XS" fieldcount "./csv.pl < /tmp/hello.csv"
timer ../results.csv perl "Text::CSV_XS" empty "./csv.pl < /tmp/empty.csv"
