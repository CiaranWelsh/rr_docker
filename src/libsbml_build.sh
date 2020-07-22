#!/bin/sh

cd /home/libsbml/
mkdir -p install

if [[ -z "${SKIP_LIBSBML}" ]]; then
    cd /home/libsbml/
    mkdir -p install

    cp /home/setup_scripts/libsbml_setup.py install/setup.py

    cd build

    #rm -rf *

    echo configuring SBML...
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install -DLIBBZ_LIBRARY=$BZIP2_LIB \
    -DLIBBZ_INCLUDE_DIR=$USR_INCLUDE -DLIBXML_LIBRARY=$LIBXML2_LIB -DLIBXML_INCLUDE_DIR=$USR_INCLUDE/libxml2 \
    -DLIBZ_LIBRARY=$LIBZ_LIB -DLIBZ_INCLUDE_DIR=$USR_INCLUDE -DENABLE_ARRAYS=ON -DENABLE_COMP=ON \
    -DENABLE_DISTRIB=ON -DENABLE_DYN=OFF -DENABLE_FBC=ON -DENABLE_GROUPS=ON -DENABLE_LAYOUT=ON -DENABLE_MULTI=ON \
    -DENABLE_QUAL=ON -DENABLE_RENDER=ON -DENABLE_REQUIREDELEMENTS=OFF -DENABLE_SPATIAL=ON \
    -DWITH_CPP_NAMESPACE=OFF -DWITH_PYTHON=ON \
    -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_INSTALL_WITH_SETUP=ON \
    -DPYTHON_USE_DYNAMIC_LOOKUP=ON -DSWIG_EXECUTABLE=$SWIG_EXE /home/libsbml/source

    echo building SBML...
    make -j4

else
    echo NOTE: skipping libSBML build.
fi

# this step is done regardless, since sbml is a dependency of antimony
echo installing SBML...
make install

cd /home/libsbml/install

echo "from .libsbml import *" > lib64/python3.${PY3_MINOR_VERSION}/site-packages/libsbml/__init__.py

echo building libSBML wheels...
python setup.py bdist_wheel

cp dist/*.whl /io

echo Done building libSBML.

