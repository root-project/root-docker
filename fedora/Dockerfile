FROM fedora

LABEL maintainer=root-dev@cern.ch

RUN dnf update -y

COPY packages packages

RUN dnf install -y $(cat packages) && rm /packages

CMD root.exe
