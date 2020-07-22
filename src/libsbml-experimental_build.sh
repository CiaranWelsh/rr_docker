#!/bin/sh

cd /home/libsbml-experimental/

if [[ -z "${SKIP_LIBSBML_EXP}" ]]; then
    echo building libsbml experimental as dependency to libnuml, etc...
    mkdir -p install

    cd build

    rm -rf *

    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install -DLIBBZ_LIBRARY=$BZIP2_LIB \
    -DLIBBZ_INCLUDE_DIR=$USR_INCLUDE -DLIBXML_LIBRARY=$LIBXML_LIB -DLIBXML_INCLUDE_DIR=$USR_INCLUDE/libxml2 \
    -DLIBZ_LIBRARY=$LIBZ_LIB -DLIBZ_INCLUDE_DIR=$USR_INCLUDE -DENABLE_ARRAYS=ON -DENABLE_COMP=ON \
    -DENABLE_DISTRIB=ON \
    -DENABLE_DYN=ON -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_L3V2EXTENDEDMATH=ON -DENABLE_LAYOUT=ON \
    -DENABLE_MULTI=ON \
    -DENABLE_QUAL=ON -DENABLE_RENDER=ON -DENABLE_REQUIREDELEMENTS=ON -DENABLE_SPATIAL=ON -DWITH_CPP_NAMESPACE=ON \
    -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE \
    -DPYTHON_INSTALL_WITH_SETUP=ON -DPYTHON_USE_DYNAMIC_LOOKUP=ON -DSWIG_EXECUTABLE=$SWIG_EXE ../source

    make -j4
else
    echo NOTE: skipping libsbml-experimental, which is a dependency of libnuml, libsedml, and phrasedml.
fi

make install

cd /home/libsbml-experimental/install

