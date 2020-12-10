FROM condaforge/miniforge3

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

ARG ROOT_VERSION=6.22.06
ARG PYTHON_VERSION=3.8

RUN apt-get update && apt-get install --yes libglu1-mesa-dev freeglut3-dev mesa-common-dev && apt-get clean && \
    conda config --set allow_softlinks false && \
    conda config --set always_copy true && \
    conda install --yes --quiet python=$PYTHON_VERSION root=$ROOT_VERSION && \
    conda clean --yes --all --force-pkgs-dirs

CMD ["root", "-b"]
