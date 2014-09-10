# CSV Game

## Introduction

The CSV Game is a collection of examples of csv parsing programs which report
the number of fields in a csv file. It began when I saw [this Rob Miller talk
from GopherCon
2014](https://www.youtube.com/watch?v=RhLIblr_YXs&index=6&list=PLEireDfbBiXYxLvhLBHi8EX_HigEplHDH)
about [Hekka](https://github.com/mozilla-services/heka) where he claims that Go
is so slow at parsing CSV messages that they pass the over protocol buffers to a
luajit process which parses the message and sends the data back over protocol
buffers - and it's quicker than just reading it in Go ([14:45 in the video](https://www.youtube.com/watch?v=RhLIblr_YXs&index=6&list=PLEireDfbBiXYxLvhLBHi8EX_HigEplHDH#t=14m45)\).
I could hardly believe this so I wrote some sample code myself to check it.
Sure enough, I found Go to be pretty slow at parsing CSV files.

I discussed this with some friends and they contributed other
versions in various languagues. So I've collected them here.

## Procedure
1. Generate the test file using the script in the test directory.

2.  Either run `time csv < /tmp/hello.csv` or `time csv /tmp/hello.csv` 
or whatever.

## Disclaimer
I don't claim that all of the implementations are representative of idiomatic
code.

## Timings

Here are some timings from my machine. 

| Language           | Time     |
|--------------------|---------:|
| C                  | 0m0.177s |
| C++ Spirit         | 0m0.981s |
| Go                 | 0m1.561s |
| Haskell            | 0m1.353s |
| Java (OpenCSV)     | 0m0.781s |
| Lua LPEG           | 0m1.139s |
| Luajit FFI         | 0m1.038s |
| Python 2.7         | 0m0.532s |
| Python 3.3         | 0m0.857s |
| Scala (mighty-csv) | 0m1.109s |

## Notes
C++ is using the Boost.Spirit library and not a specific library for parsing
CSV.

Lua is using a library for parsing LPEG grammars.

Luajit FFI is using the C libcsv library through a foreign function interface.

Haskell is using the Cassava library.

## Rudimentary Analysis

Profiling the Go code, I can see that a lot of the time goes to Garbage
collection. A lot of the time also goes to handling UFT8. 
