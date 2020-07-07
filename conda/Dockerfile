FROM continuumio/miniconda3

ARG ROOT_VERSION=6.22.00
ARG PYTHON_VERSION=3.7

RUN conda config --add channels conda-forge && \
    conda config --set allow_softlinks false && \
    conda config --set always_copy true && \
    conda install --yes --quiet python=$PYTHON_VERSION root=$ROOT_VERSION && \
    conda clean --yes --all --force-pkgs-dirs
