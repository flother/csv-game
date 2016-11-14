#!/bin/bash
source ../build.sh

mvn package
readonly bindir=$(realpath "$(dirname "$0")")
readonly csv_path=$bindir/target/scala-csv-1.0-SNAPSHOT-jar-with-dependencies.jar
readonly cmd="java -cp ${csv_path} ScalaCsv"
timer ../results.csv scala MightyCsv fieldcount "$cmd < /tmp/hello.csv"
timer ../results.csv scala MightyCsv empty "$cmd < /tmp/empty.csv"
