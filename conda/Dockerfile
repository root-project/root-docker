FROM continuumio/miniconda3:4.7.12

ARG ROOT_VERSION=6.20.00
ARG PYTHON_VERSION=3.7

RUN conda config --add channels conda-forge && \
    conda install --quiet python=$PYTHON_VERSION root=$ROOT_VERSION
