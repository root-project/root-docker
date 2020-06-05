FROM ubuntu:20.04

ENV LANG=C.UTF-8
ARG VERSION=6.20.04

WORKDIR /tmp

COPY packages packages-dev build.sh /tmp/

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat packages packages-dev) \
 && ./build.sh \
 && apt-get --purge autoremove -y $(cat packages-dev) \
 && dpkg -l $(cat packages) \
 && rm -rf /var/lib/apt/lists/* /tmp/*

ENV PYTHONPATH=/usr/local/lib/root

CMD [ "root.exe" ]
