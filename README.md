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

## Contributing

As I don't claim that all the implementations are representative of idiomatic code, PRs are most certainly
welcome! However, keep in mind that I would like to keep this idiomatic so I will be very skeptical of 
contributions where a parser is configured to drop all features in the intent of gaming results.

## Timings

Here are some timings from my machine. 

| Language            | Time     |
|---------------------|---------:|
| C (libcsv)          | 0m0.177s |
| C++ (Spirit)        | 0m0.981s |
| Go                  | 0m1.561s |
| Haskell (Cassava)   | 0m1.353s |
| Java (BeanIO)       | 0m1.785s |
| Java (CSVeed)       | 0m8.218s |
| Java (CommonsCSV)   | 0m1.345s |
| Java (JavaCSV)      | 0m0.697s |
| Java (OpenCSV)      | 0m0.679s |
| Java (UnivocityCSV) | 0m0.528s |
| Julia (0.3.1)       | 0m3.639s |
| Lua LPEG            | 0m1.139s |
| Luajit FFI          | 0m1.038s |
| Perl (Text::CSV\_XS)| 0m2.258s |
| Python 2.7          | 0m0.532s |
| Python 3.3          | 0m0.857s |
| R                   | 0m2.050s |
| Ruby                | 0m11.898s|
| Scala (mighty-csv)  | 0m1.109s |

## Notes
C++ is using the Boost.Spirit library and not a specific library for parsing
CSV.

Lua is using a library for parsing LPEG grammars.

Luajit FFI is using the C libcsv library through a foreign function interface.

R reads the CSV file into a DataFrame and multiplies the product of the
dimensions rather than counting each individual record.  This may be a bit
cheaty.

Julia works in a similar fashion to R and reads the CSV file into an
Array{Any,2} and multiplies the product of the dimensions rather than counting
each individual record. Like the R version, this might be a bit cheaty.

## Rudimentary Analysis

Profiling the Go code, I can see that a lot of the time goes to Garbage
collection. A lot of the time also goes to handling UFT8. 
