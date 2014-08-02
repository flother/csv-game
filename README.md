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
I don't claim to analyse why the timings are why they are they way they are or
that some of the implementations are representative of idiomatic code.

Particularly egregious is the Haskell code where I couldn't figure out how to
count the fields in a row and so I hard coded it. I'd be happy for someone to
contribute code to fix it.

## Timings

Here are some timings from my machine. 

| Language   | Time     |
|------------|---------:|
| C          | 0m0.177s |
| C++ Spirit | 0m0.981s |
| Go         | 0m1.561s |
| Haskell    | 0m1.890s |
| Lua        | 0m1.139s |
| Python 2.7 | 0m0.532s |
| Python 3.3 | 0m0.857s |
