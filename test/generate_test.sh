#!/bin/bash

# Simple csv file which should flex escaping a little.
for i in $(seq 1 1000000); 
  do echo 'hello,","," ",world,"!"'; 
done > /tmp/hello.csv

# Test for 'hello world'
touch /tmp/empty.csv

