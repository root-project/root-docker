FROM continuumio/miniconda3

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

ARG ROOT_VERSION=6.22.02
ARG PYTHON_VERSION=3.8

RUN conda config --add channels conda-forge && \
    conda config --set allow_softlinks false && \
    conda config --set always_copy true && \
    conda install --yes --quiet python=$PYTHON_VERSION root=$ROOT_VERSION && \
    conda clean --yes --all --force-pkgs-dirs

CMD ["root", "-b"]
