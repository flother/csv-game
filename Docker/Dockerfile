FROM debian

# File Author / Maintainer
MAINTAINER Ewan Higgs <ewan_higgs@yahoo.co.uk>

ENV DEBIAN_FRONTEND=noninteractive

ENV C_DEPS="libcsv-dev"
ENV CPP_DEPS="libboost-dev"
ENV R_DEPS="r-base r-base-dev libopenblas-base"
ENV JAVA_DEPS="openjdk-7-jdk openjdk-7-jre maven"
ENV PYTHON2_DEPS="python python-dev python-pip"
ENV PYTHON3_DEPS="python3 python3-dev python3-pip"
ENV RUBY_DEPS="ruby"
ENV LUA_DEPS="lua5.1 luajit luarocks"
ENV GOLANG_DEPS="golang"
ENV HASKELL_DEPS="ghc libghc-text-dev libghc-cassava-dev"
ENV OCAML_DEPS="ocaml opam"
ENV JULIA_DEPS="julia"
ENV PHP_DEPS="php5"

# General tools
RUN apt-get update && \
    apt-get install \
       ca-certificates \
       curl \
       gcc \
       libc6-dev \
       $C_DEPS \
       $CPP_DEPS \
       $R_DEPS \
       $JAVA_DEPS \
       $PYTHON2_DEPS \
       $PYTHON3_DEPS \
       $RUBY_DEPS \
       $LUA_DEPS \
       $GOLANG_DEPS \
       $HASKELL_DEPS \
       $OCAML_DEPS \
       $JULIA_DEPS \
       $PHP_DEPS \
       -qqy \
       --no-install-recommends \ 
       && rm -rf /var/lib/apt/lists/*

RUN pip install pandas
RUN luarocks install lpeg
RUN cpan install perl Text::CSV_XS
RUN opam init && opam install -y csv

RUN mkdir /rust
RUN pwd
WORKDIR /rust

# Rust
ENV RUST_ARCHIVE=rust-nightly-x86_64-unknown-linux-gnu.tar.gz
ENV RUST_DOWNLOAD_URL=https://static.rust-lang.org/dist/$RUST_ARCHIVE

RUN curl -fsOSL $RUST_DOWNLOAD_URL \
    && curl -s $RUST_DOWNLOAD_URL.sha256 | sha256sum -c - \
    && tar -C /rust -xzf $RUST_ARCHIVE --strip-components=1 \
    && rm $RUST_ARCHIVE \
    && ./install.sh

# Clojure
ENV LEIN_ROOT 1

# Install Leiningen and make executable
RUN curl -s https://raw.githubusercontent.com/technomancy/leiningen/2.6.1/bin/lein > \
            /usr/local/bin/lein && \
            chmod 0755 /usr/local/bin/lein && \
            /usr/local/bin/lein

WORKDIR /

