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

1. `fieldcount`: Count the number of fields in the file. This exercises the CSV processing library by forcing it to parse all the fields. There is a separate run called `empty` which runs against an empty file and it is used as an attempt to tease out the performance of the actual CSV parsing from the startup for the runtime (importing modules, loading libraries, instantiating structures, etc). 

2. `csv-count`: Take the sum of one of the columns in the file. This exercises the CSV parsing library, string to integer parsing, and basic maths. I saw [textql](https://github.com/dinedal/textql) which slurps data into sqlite and runs queries on the resulting database. I thought it's a cool idea, but could it possibly be performant? This test would probably be better named as `csv-summer`

## Timings

Here are some timings from whatever virtual machine/container system runs on [Wercker](https://app.wercker.com/#ehiggs/csv-game/build/5779804f3ec144923a007af6) for the `fieldcount`. 

| Language |Library        |Time      | Time sans startup|
-----------|---------------|----------|------------------:
|Rust      |quick-reader   |0.112     |0.111             |
|Rust      |csvreader      |0.118     |0.117             |
|C         |libcsv         |0.127     |0.126             |
|Rust      |libcsv-reader  |0.128     |0.126             |
|C++       |spirit         |0.202     |0.201             |
|Java      |UnivocityCsv   |0.460     |0.352             |
|Python2   |csv            |0.363     |0.353             |
|Python2   |pandas         |0.581     |0.387             |
|Java      |JavaCsv        |0.531     |0.442             |
|Python3   |csv            |0.514     |0.494             |
|Java      |OpenCsv        |0.615     |0.526             |
|Scala     |MightyCsv      |0.956     |0.699             |
|Luajit    |libcsv         |0.981     |0.980             |
|Rust      |nom-reader     |1.011     |1.010             |
|Lua       |lpeg           |1.019     |1.017             |
|Rust      |peg-reader     |1.039     |1.038             |
|Rust      |lalr-reader    |1.081     |1.080             |
|Java      |CommonsCsv     |1.291     |1.198             |
|Golang    |csv            |1.287     |1.286             |
|Haskell   |cassava        |1.319     |1.318             |
|C++       |tokenizer      |1.325     |1.324             |
|Java      |BeanIOCsv      |1.672     |1.583             |
|Clojure   |csv            |2.544     |1.606             |
|Julia     |dataframe      |3.400     |1.715             |
|Php       |csv            |2.179     |2.170             |
|R         |dataframe      |2.273     |2.187             |
|Perl      |Text::CSV_XS   |2.257     |2.234             |
|Java      |CSVeedCsv      |7.383     |7.104             |
|Ruby      |csv            |9.927     |9.891             |

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
The following variants are using general parsing libraries for processing the CSV: 

* C++ Boost.Spirit.
* Lua lpeg (a [PEG](https://en.wikipedia.org/wiki/Parsing_expression_grammar) library).
* Rust PEG.
* Rust lalrpop (a [LALR](https://en.wikipedia.org/wiki/LALR_parser) parser).
* Rust NOM (a [parser combinator](https://en.wikipedia.org/wiki/Parser_combinator) library).

Luajit FFI is using the C libcsv library through a foreign function interface.

R reads the CSV file into a DataFrame and multiplies the product of the
dimensions rather than counting each individual record.  This may be a bit
cheaty. Pandas does this too.

Julia works in a similar fashion to R and reads the CSV file into an
Array{Any,2} and multiplies the product of the dimensions rather than counting
each individual record. Like the R version, this might be a bit cheaty.

SQLite makes a table and imports the csv file and then runs a query.

There is also a perl6 version but unfortunately it takes a very long time to run
(minutes). Rakudo/moar/perl6 is [under active development and performance
improvements](http://tux.nl/Talks/CSV6/speed4.html) so I expect this will
get much faster in the future. When a breakthrough occurs, let me know and I'd
love to add it to the game.

I wish AWK had a `--csv` flag which did something useful for quoted csv files. I
would love to add awk, gawk, mawk, and nawk.

## Rudimentary Analysis

Profiling the Go code, I can see that a lot of the time goes to Garbage
collection. A lot of the time also goes to handling UFT8. 

Slurping data into SQLite for interactive analysis isn't so bad, actually.
