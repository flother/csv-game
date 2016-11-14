#!/usr/bin/env julia
try
    arr = readcsv("/dev/stdin")
    x, y = size(arr)
    println(x * y)
catch e
        println(0)
end
