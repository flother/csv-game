#!/usr/bin/env julia
arr = readcsv("/dev/stdin")
x, y = size(arr)
println(x * y)
