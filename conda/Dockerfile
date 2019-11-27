FROM continuumio/miniconda3

ARG ROOT_VERSION=6.18.04
ARG PYTHON_VERSION=3.7

RUN conda config --add channels conda-forge && \
    conda install --quiet python=$PYTHON_VERSION root=$ROOT_VERSION
