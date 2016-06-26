#!/bin/bash
(cd csvreader && ocamlbuild -package csv csvreader.native)
time ./csvreader/csvreader.native < /tmp/hello.csv
