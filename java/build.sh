#!/bin/bash
source ../build.sh
mvn package
timer ../results.csv java BeanIOCsv fieldcount "./BeanIOCsv < /tmp/hello.csv"
timer ../results.csv java BeanIOCsv empty "./BeanIOCsv < /tmp/empty.csv"
timer ../results.csv java CommonsCsv fieldcount "./CommonsCsv < /tmp/hello.csv"
timer ../results.csv java CommonsCsv empty "./CommonsCsv < /tmp/empty.csv"
timer ../results.csv java CSVeedCsv fieldcount "./CSVeedCsv < /tmp/hello.csv"
timer ../results.csv java CSVeedCsv empty "./CSVeedCsv < /tmp/empty.csv"
timer ../results.csv java JavaCsv fieldcount "./JavaCsv < /tmp/hello.csv"
timer ../results.csv java JavaCsv empty "./JavaCsv < /tmp/empty.csv"
timer ../results.csv java OpenCsv fieldcount "./OpenCsv < /tmp/hello.csv"
timer ../results.csv java OpenCsv empty "./OpenCsv < /tmp/empty.csv"
timer ../results.csv java UnivocityCsv fieldcount "./UnivocityCsv < /tmp/hello.csv"
timer ../results.csv java UnivocityCsv empty "./UnivocityCsv < /tmp/empty.csv"
