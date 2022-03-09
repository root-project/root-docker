# WARNING: this Dockerfile is unmaintained

ARG CENTOS_VERSION=7

FROM centos:$CENTOS_VERSION

COPY packages packages

RUN yum update -q -y && \
	yum install -y epel-release && \
	yum install -y $(cat packages) && \
	localedef -i en_US -f UTF-8 en_US.UTF-8 && \
	rm -f /packages

ARG CMAKE_CXX_STANDARD=17
ARG ROOT_VERSION=master

ENV ROOTSYS /usr/local/root
ENV PATH $ROOTSYS/bin:$PATH
ENV PYTHONPATH $ROOTSYS/lib:$PYTHONPATH
ENV CLING_STANDARD_PCH none

RUN cd /tmp && \
	git clone https://github.com/root-project/root.git $ROOTSYS/source && \
	cd $ROOTSYS/source && git reset --hard ${ROOT_VERSION} && \
	cmake3 $ROOTSYS/source \
	-DCMAKE_INSTALL_PREFIX=$ROOTSYS -DCMAKE_CXX_STANDARD=$CMAKE_CXX_STANDARD \
	-Dall=ON \
	-Dcxx11=ON \
	-Dfail-on-missing=ON \
	-Dgnuinstall=ON \
	-Drpath=ON \
	-Dbuiltin_afterimage=OFF \
	-Dbuiltin_ftgl=OFF \
	-Dbuiltin_gl2ps=OFF \
	-Dbuiltin_glew=OFF \
	-Dbuiltin_tbb=ON \
	-Dbuiltin_unuran=OFF \
	-Dbuiltin_vdt=ON \
	-Dbuiltin_veccore=ON \
	-Dbuiltin_xrootd=OFF \
	-Darrow=OFF \
	-Dcastor=OFF \
	-Dchirp=OFF \
	-Dgeocad=OFF \
	-Dglite=OFF \
	-Dhdfs=OFF \
	-Dmonalisa=OFF \
	-Doracle=OFF \
	-Dpythia6=OFF \
	-Drfio=OFF \
	-Droot7=OFF \
	-Dsapdb=OFF \
	-Dsrp=OFF \
	-Dvc=OFF && \
	cmake3 --build . -- -j$(nproc) && \
	cmake3 --build . --target install && \
	rm -rf $ROOTSYS/source /tmp/*

CMD ["root", "-b"]
