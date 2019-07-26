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

WORKDIR /pyo3

ADD Cargo.toml /pyo3
ADD src /pyo3/src
ADD one_time_pad /pyo3/one_time_pad
ADD MANIFEST.in /pyo3
ADD setup.py /pyo3
