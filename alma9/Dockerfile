FROM gitlab-registry.cern.ch/linuxsupport/alma9-base

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

ENV LANG=C.UTF-8

ARG ROOT_BIN=root_v6.30.02.Linux-almalinux9.3-x86_64-gcc11.4.tar.gz

WORKDIR /opt

COPY packages packages

RUN dnf update -q -y \
 && dnf install -y epel-release \
 && dnf install -y $(cat packages)\
 && rm -f packages \
 && curl -O https://root.cern/download/${ROOT_BIN} \
 && tar -xzvf ${ROOT_BIN} \
 && rm -f ${ROOT_BIN} \
 && echo /opt/root/lib >> /etc/ld.so.conf \
 && ldconfig

ENV ROOTSYS /opt/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONPATH $ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH none

CMD ["root", "-b"]
