FROM condaforge/mambaforge

LABEL maintainer.name="ROOT team"
LABEL maintainer.email="root-dev@cern.ch"

ARG ROOT_VERSION=6.26.06
ARG PYTHON_VERSION=3.10

COPY entry_point.sh /

RUN apt-get update && apt-get install --yes libglu1-mesa-dev freeglut3-dev mesa-common-dev && apt-get clean && \
    conda config --set allow_softlinks false && \
    conda config --set always_copy true && \
    mamba install --yes --quiet python=$PYTHON_VERSION root=$ROOT_VERSION && \
    conda clean --yes --all --force-pkgs-dirs && \
    chmod +x /entry_point.sh

ENTRYPOINT ["/entry_point.sh"]
CMD ["root", "-b"]
