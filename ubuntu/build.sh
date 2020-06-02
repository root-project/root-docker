#!/bin/bash

set -e

: ${VERSION:?must be set to ROOT version to build}
: ${SRC_URI:=https://root.cern/download/root_v${VERSION}.source.tar.gz}

: ${SOURCE_DIR:=/tmp/root}
: ${BINARY_DIR:=/tmp/root_build}

mkdir -p ${SOURCE_DIR} ${BINARY_DIR}
curl -sL ${SRC_URI} | tar xz --strip-components=1 -C ${SOURCE_DIR}

declare -a BUILD_OPTIONS

BUILD_OPTIONS=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_CXX_STANDARD=17
		-DPYTHON_EXECUTABLE=/usr/bin/python3
		-DCLING_BUILD_PLUGINS=OFF
		-Dfail-on-missing=ON
		-Dsoversion=ON
		-Dgnuinstall=ON
		-Dexceptions=ON
		-Dbuiltin_llvm=ON
		-Dbuiltin_clang=ON
		-Dbuiltin_afterimage=OFF
		-Dbuiltin_cfitsio=OFF
		-Dbuiltin_davix=OFF
		-Dbuiltin_fftw3=OFF
		-Dbuiltin_freetype=OFF
		-Dbuiltin_ftgl=OFF
		-Dbuiltin_gl2ps=OFF
		-Dbuiltin_glew=OFF
		-Dbuiltin_gsl=OFF
		-Dbuiltin_lz4=OFF
		-Dbuiltin_lzma=OFF
		-Dbuiltin_openssl=OFF
		-Dbuiltin_pcre=OFF
		-Dbuiltin_tbb=OFF
		-Dbuiltin_unuran=ON # not in ubuntu
		-Dbuiltin_vc=OFF
		-Dbuiltin_vdt=OFF
		-Dbuiltin_veccore=OFF
		-Dbuiltin_xrootd=ON # not in ubuntu
		-Dbuiltin_xxhash=OFF
		-Dbuiltin_zlib=OFF
		-Dbuiltin_zstd=OFF
		-Dx11=ON
		-Dalien=OFF
		-Darrow=OFF
		-Dasimage=ON
		-Dccache=OFF
		-Dcefweb=OFF
		-Dclad=OFF
		-Dcuda=OFF
		-Dcudnn=OFF
		-Dcxxmodules=OFF # requires clang, unstable
		-Ddavix=ON
		-Ddataframe=ON
		-Ddcache=ON
		-Dfcgi=ON
		-Dfftw3=ON
		-Dfitsio=ON
		-Dfortran=ON
		-Dftgl=ON
		-Dgdml=ON
		-Dgfal=ON
		-Dgl2ps=ON
		-Dgminimal=OFF
		-Dgsl_shared=ON
		-Dgviz=ON
		-Dhttp=ON
		-Dimt=ON
		-Djemalloc=OFF
		-Dmathmore=ON
		-Dmemstat=OFF # deprecated, removed in 6.20
		-Dminimal=OFF
		-Dminuit2=ON
		-Dminuit=ON
		-Dmlp=ON
		-Dmonalisa=OFF
		-Dmpi=OFF
		-Dmysql=ON
		-Dodbc=ON
		-Dopengl=ON
		-Doracle=OFF
		-Dpgsql=ON
		-Dpythia6=OFF
		-Dpythia8=ON
		-Dpyroot=ON # python was renamed to pyroot
		-Dpython=ON # kept for backward compatibility
		-Dpyroot_legacy=ON # new with 6.22
		-Dpyroot_experimental=OFF # kept for backward compatibility
		-Dqt5web=OFF
		-Droofit=ON
		-Droot7=ON
		-Drootbench=OFF
		-Droottest=OFF
		-Drpath=ON
		-Druntime_cxxmodules=ON
		-Dr=OFF
		-Dshadowpw=ON
		-Dsqlite=ON
		-Dssl=ON
		-Dtcmalloc=OFF
		-Dtesting=OFF
		-Dtmva=ON
		-Dtmva-cpu=ON
		-Dtmva-gpu=OFF
		-Dtmva-pymva=ON
		-Dtmva-rmva=OFF
		-Dunuran=ON
		-Dvc=OFF
		-Dvmc=OFF
		-Dvdt=OFF
		-Dveccore=OFF
		-Dvecgeom=OFF
		-Dxml=ON
		-Dxrootd=ON
		-Dxproofd=OFF
		)

cmake -S ${SOURCE_DIR} -B ${BINARY_DIR} ${BUILD_OPTIONS[@]}
cmake --build ${BINARY_DIR} -- -j$(($(nproc) * 3/4))
cmake --build ${BINARY_DIR} --target install

rm -rf ${SOURCE_DIR} ${BINARY_DIR} /tmp/*
