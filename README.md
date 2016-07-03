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

4. Alternatively, pull down [the 901MB docker image](https://hub.docker.com/r/ehiggs/csv-game/) and run them using `wercker build`.

## Disclaimer
I don't claim that all of the implementations are representative of idiomatic
code.

## Contributing

As I don't claim that all the implementations are representative of idiomatic code, PRs are most certainly welcome! However, keep in mind that I would like to keep the code plausible so I will be very skeptical of contributions where a parser is configured to drop all features in the intent of gaming results.

## The Tests
There are two tests. 

1. `fieldcount`: Count the number of fields in the file. This exercises the CSV processing library by forcing it to parse all the fields. There is a separate run called `empty` which runs against an empty file and it used as an attempt to tease out the performance of the actual CSV parsing from the startup for the runtime (importing modules, loading libraries, instantiating structures, etc). 

2. `csv-count`: Take the sum of one of the columns in the file. This exercises the CSV parsing library, string to integer parsing, and basic maths. I saw [textql](https://github.com/dinedal/textql) which slurps data into sqlite and runs queries on the resulting database. I thought it's a cool idea, but could it possibly be performant? This test would probably be better named as `csv-summer`

## Timings

Here are some timings from whatever virtual machine/container system runs on [Wercker](https://app.wercker.com/#ehiggs/csv-game/build/5779804f3ec144923a007af6) for the `fieldcount`. 

| Language |Library        |Time      | Time sans startup|
-----------|---------------|----------|------------------:
|Rust      |quick          |0m0.133   |0m0.124           |
|Rust      |csv            |0m0.133   |0m0.126           |
|Rust      |libcsv         |0m0.137   |0m0.127           |
|C         |libcsv         |0m0.131   |0m0.130           |
|C++       |spirit         |0m0.212   |0m0.211           |
|Python2   |csv (stdlib)   |0m0.376   |0m0.367           |
|Python2   |pandas         |0m0.963   |0m0.735           |
|Python3   |csv (stdlib)   |0m0.527   |0m0.508           |
|Java      |UnivocityCsv   |0m1.016   |0m0.906           |
|Luajit    |libcsv         |0m0.987   |0m0.986           |
|Java      |JavaCsv        |0m1.133   |0m1.038           |
|Java      |OpenCsv        |0m1.177   |0m1.087           |
|Lua       |lpeg           |0m1.050   |0m1.049           |
|Golang    |csv            |0m1.318   |0m1.317           |
|Haskell   |cassava        |0m1.330   |0m1.329           |
|C++       |tokenizer      |0m1.360   |0m1.359           |
|Julia     |dataframe      |0m3.504   |0m1.709           |
|Java      |CommonsCsv     |0m1.879   |0m1.786           |
|Clojure   |csv            |0m3.349   |0m2.245           |
|Perl      |Text::CSV_XS   |0m2.274   |0m2.251           |
|php       |csv            |0m2.233   |0m2.225           |
|R         |dataframe      |0m2.581   |0m2.480           |
|Java      |BeanIOCsv      |0m2.931   |0m2.840           |
|Ruby      |csv (stdlib)   |0m10.376  |0m10.340          |
|Java      |CSVeedCsv      |0m15.186  |0m14.790          |

Here are some timings for the `csv-count` test (which are old and haven't been added to the Continuous Integration).

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
cheaty. Pandas does this too.

Julia works in a similar fashion to R and reads the CSV file into an
Array{Any,2} and multiplies the product of the dimensions rather than counting
each individual record. Like the R version, this might be a bit cheaty.

SQLite makes a table and imports the csv file and then runs a query.

## Rudimentary Analysis

Profiling the Go code, I can see that a lot of the time goes to Garbage
collection. A lot of the time also goes to handling UFT8. 

Slurping data into SQLite for interactive analysis isn't so bad, actually.