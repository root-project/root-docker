FROM cern/cc7-base

COPY packages packages

RUN yum update -q -y \
 && yum install -y epel-release \
 && yum install -y $(cat packages) \
 && localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && rm -f /packages

CMD root -b
