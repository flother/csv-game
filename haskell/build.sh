#!/bin/bash
source ../build.sh
ghc Csv.hs
timer ../results.csv haskell cassava fieldcount "./Csv < /tmp/hello.csv"
timer ../results.csv haskell cassava empty "./Csv < /tmp/empty.csv"
