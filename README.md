# CSV Game

## Introduction

The CSV Game is a collection of examples of csv parsing programs which have two
tests: report the number of fields in a csv file and take the sum of the values
in a single column. It began when I saw [this Rob Miller talk from GopherCon
2014](https://www.youtube.com/watch?v=RhLIblr_YXs&index=6&list=PLEireDfbBiXYxLvhLBHi8EX_HigEplHDH)
about [Hekka](https://github.com/mozilla-services/heka) where he claims that Go
is so slow at parsing CSV messages that they pass the data over protocol buffers to a
luajit process which parses the message and sends the data back over protocol
buffers - and it's quicker than just reading it in Go ([14:45 in the
video](https://www.youtube.com/watch?v=RhLIblr_YXs&index=6&list=PLEireDfbBiXYxLvhLBHi8EX_HigEplHDH#t=14m45)\).
I could hardly believe this so I wrote some sample code myself to check it.
Sure enough, I found Go to be pretty slow at parsing CSV files.

I discussed this with some friends and they contributed other
versions in various languagues. So I've collected them here.

## Procedure
1. Generate the test file using the script in the test directory.

2.  Either run `time csv < /tmp/hello.csv` or `time csv /tmp/hello.csv` 
or whatever.

3. For csv-count, run `time csv-count 5 /tmp/count.csv` where `5` is the column
   to sum.

## Disclaimer
I don't claim that all of the implementations are representative of idiomatic
code.

## Contributing

As I don't claim that all the implementations are representative of idiomatic code, PRs are most certainly
welcome! However, keep in mind that I would like to keep this idiomatic so I will be very skeptical of 
contributions where a parser is configured to drop all features in the intent of gaming results.

## The Tests
There are two tests. 

1. `csvreader`: Count the number of fields in the file. This exercises the CSV processing library by forcing
it to parse all the fields.

2. `csv-count`: Take the sum of one of the columns in the file. This exercises the CSV parsing library, string 
to integer parsing, and basic maths. I saw [textql](https://github.com/dinedal/textql) which slurps data into 
sqlite and runs queries on the resulting database. I thought it's a cool idea, but could it possibly be 
performant? This test would probably be better named as `csv-summer`

## Timings

Here are some timings from my machine for the field count. 

| Language            | Time     |
----------------------|----------:
| C (libcsv)          | 0m0.136s |
| C++ (Spirit)        | 0m0.229s |
| Clojure (data.csv)  | 0m3.127s |
| Go (Go 1.5)         | 0m1.225s |
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
| Ocaml               | 0m0.474s |
| Perl (Text::CSV\_XS)| 0m2.258s |
| PHP 5.5             | 0m2.576s |
| Python 2.7          | 0m0.532s |
| Python 3.3          | 0m0.857s |
| R                   | 0m2.050s |
| Ruby                | 0m11.898s|
| Rust (csv)          | 0m0.135s |
| Rust (quick)        | 0m0.099s |
| Rust (libcsv)       | 0m0.136s |
| Scala (mighty-csv)  | 0m1.109s |

Here are some timings for the `csv-count` test.

| Language            | Time     |
----------------------|----------:
| C (libcsv)          | 0m0.177s |
| Go (Go 1.5)         | 0m1.383s |
| Java (OpenCSV)      | 0m0.767s |
| Java (UnivocityCSV) | 0m0.627s |
| Lua LPEG            | 0m1.437s |
| Luajit FFI          | 0m1.486s |
| Ocaml               | 0m0.522s |
| Perl (Text::CSV\_XS)| 0m2.519s |
| Python 2.7          | 0m1.077s |
| Ruby                | 0m11.924s|
| Rust (csv)          | 0m0.172s |
| Rust (quick)        | 0m0.138s |
| SQLite3             | 0m1.834s |

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

SQLite makes a table and imports the csv file and then runs a query.

## Rudimentary Analysis

Profiling the Go code, I can see that a lot of the time goes to Garbage
collection. A lot of the time also goes to handling UFT8. 

Slurping data into SQLite for interactive analysis isn't so bad, actually.
