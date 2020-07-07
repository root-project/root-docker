FROM ubuntu:20.04

ENV LANG=C.UTF-8

WORKDIR /tmp/env-files

COPY packages packages
COPY sourceroot.sh sourceroot.sh

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat packages) \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://root.cern/download/root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz \
 && tar -xzvf root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz \
 && rm -f root_v6.22.00.Linux-ubuntu20-x86_64-gcc9.3.tar.gz

ENTRYPOINT ["/tmp/env-files/sourceroot.sh"]
