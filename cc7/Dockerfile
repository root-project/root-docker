FROM cern/cc7-base

COPY packages packages

RUN yum update -q -y \
 && yum install -y epel-release \
 && yum install -y $(cat packages) \
 && localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && rm -f /packages

RUN cd /tmp \
 && git clone https://github.com/root-project/root /usr/src/root \
 && cmake3 /usr/src/root \
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
	-Dvc=OFF \
 && cmake3 --build . -- -j$(nproc) \
 && cmake3 --build . --target install \
 && rm -rf /usr/src/root /tmp/*

ENV PYTHONPATH /usr/local/lib
CMD root -b
