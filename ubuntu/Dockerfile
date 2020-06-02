FROM ubuntu:20.04

ENV LANG=C.UTF-8
ARG VERSION=6.20.04

WORKDIR /root

COPY packages packages

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat packages) \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

COPY build.sh build.sh

RUN ./build.sh

ENV PYTHONPATH=/usr/local/lib/root

CMD [ "root.exe" ]
