FROM fedora:37

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

COPY packages packages

RUN dnf update -y \
 && dnf install -y $(cat packages) \
 && rm /packages

CMD ["root", "-b"]
