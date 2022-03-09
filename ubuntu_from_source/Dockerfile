ARG UBUNTU_VERSION=20.04

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

ARG CMAKE_CXX_STANDARD=17
ARG ROOT_VERSION=master

# clone build and install
RUN git clone https://github.com/root-project/root.git $ROOTSYS/source && \
    cd $ROOTSYS/source && git reset --hard ${ROOT_VERSION} && \
    mkdir -p $ROOTSYS/build &&  cd $ROOTSYS/build && \
    cmake $ROOTSYS/source -DCMAKE_INSTALL_PREFIX=$ROOTSYS -DCMAKE_CXX_STANDARD=$CMAKE_CXX_STANDARD -Dbuiltin_afterimage=ON && \
    make -j$(nproc) install && \
    rm -rf $ROOTSYS/build $ROOTSYS/source

WORKDIR $ROOTSYS

CMD ["root", "-b"]
