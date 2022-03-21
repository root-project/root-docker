# Ubuntu image tags as they appear here: https://hub.docker.com/_/ubuntu. Example: UBUNTU_VERSION=20.04
ARG UBUNTU_VERSION=20.04
# ROOT version in the MAJOR.MINOR.REVISION format. Example: ROOT_VERSION=6.26.00
ARG ROOT_VERSION
# C++ standard to compile ROOT. Example: CMAKE_CXX_STANDARD=17
ARG CMAKE_CXX_STANDARD

FROM ubuntu:$UBUNTU_VERSION

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

ENV LANG=C.UTF-8

COPY packages packages

RUN apt-get update -qq && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime && \
    apt-get -y install $(cat packages) wget git && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

ENV ROOTSYS /opt/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONPATH $ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH none

RUN echo $ROOTSYS/lib >> /etc/ld.so.conf && \
    ldconfig

RUN yes | unminimize

# clone build and install
ARG ROOT_VERSION=6.26.00
ARG CMAKE_CXX_STANDARD=17

RUN ROOT_GIT_REVISION="v$(echo $ROOT_VERSION | cut -d. -f1)-$(echo $ROOT_VERSION | cut -d. -f2)-$(echo $ROOT_VERSION | cut -d. -f3)" \
    && git clone --branch $ROOT_GIT_REVISION --depth=1 https://github.com/root-project/root.git $ROOTSYS/source \
    && cd $ROOTSYS/source \
    && mkdir -p $ROOTSYS/build &&  cd $ROOTSYS/build \
    && cmake $ROOTSYS/source \
    -DCMAKE_INSTALL_PREFIX=$ROOTSYS \
    -DCMAKE_CXX_STANDARD=$CMAKE_CXX_STANDARD \
    -Dbuiltin_afterimage=ON \
    && make -j$(nproc) install \
    && rm -rf $ROOTSYS/build $ROOTSYS/source

WORKDIR /opt

CMD ["root", "-b"]
