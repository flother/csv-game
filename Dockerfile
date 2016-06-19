FROM debian

# File Author / Maintainer
MAINTAINER Ewan Higgs <ewan_higgs@yahoo.co.uk>

RUN apt-get update
# C, luajit-ffi
RUN apt-get install -y build-essential libcsv-dev
# C++
RUN apt-get install -y libboost-dev
# R
RUN apt-get install -y r-base r-base-dev libopenblas-base 
# Java
RUN apt-get install -y openjdk-7-jdk openjdk-7-jre maven
# Python2, Python3, Ruby
RUN apt-get install -y python python3 ruby
# Lua, Luajit
RUN apt-get install -y lua5.2 luajit luarocks
# Go
RUN apt-get install -y golang 
# Others
#RUN apt-get install -y ghc ocaml rust

RUN luarocks install lpeg
