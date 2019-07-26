version = $(shell awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g')
release := "1"
uniq := $(shell head -c1000 /dev/urandom | sha512sum | head -c 12 ; echo ;)
cidfile := "/tmp/.tmp.docker.$(uniq)"
build_type := release

all:
	mkdir -p build/ && \
	cp -a Cargo.toml src one_time_pad Makefile setup.py Dockerfile MANIFEST.in build/ && \
	cd build/ && \
	docker build -t one_time_pad/build_rust:ubuntu18.04 . && \
	cd ../ && \
	rm -rf build/

cleanup:
	docker rmi `docker images | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

dev:
	docker run -it --rm -v `pwd`:/one_time_pad one_time_pad/build_rust:ubuntu18.04 /bin/bash || true

get_version:
	echo $(version)
