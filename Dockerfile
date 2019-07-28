FROM ubuntu:bionic
MAINTAINER Daniel Boline

RUN apt-get update && \
    apt-get install -y curl pkg-config checkinstall gcc libssl-dev ca-certificates \
            file build-essential autoconf automake autotools-dev libtool xutils-dev \
            git libusb-dev libxml2-dev libpq-dev python3-dev python-dev python3-setuptools \
            python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://sh.rustup.rs > rustup.sh && \
    sh rustup.sh -y --default-toolchain nightly && \
    . ~/.cargo/env

RUN pip3 install setuptools-rust

WORKDIR /one_time_pad

ADD Cargo.toml /one_time_pad
ADD src /one_time_pad/src
ADD one_time_pad /one_time_pad/one_time_pad
ADD MANIFEST.in /one_time_pad
ADD setup.py /one_time_pad
