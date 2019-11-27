FROM fedora

LABEL maintainer=root-dev@cern.ch

COPY packages packages

RUN dnf update -y \
 && dnf install -y $(cat packages) \
 && rm /packages

CMD root.exe
