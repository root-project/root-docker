ARG FEDORA_VERSION=35

FROM fedora:$FEDORA_VERSION

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

COPY packages packages

RUN dnf update -y && \
    dnf install -y $(cat packages) && \
    rm /packages

CMD ["root", "-b"]
