#!/bin/bash

timer () {
  local result_file=$1; shift
  local language=$1; shift
  local library=$1; shift
  local task=$1; shift
  TIMEFORMAT="$language,$library,$task,%R"
  for i in $(seq 1 10); do
    (time eval "$@") 2>> "$result_file"
  done
}
