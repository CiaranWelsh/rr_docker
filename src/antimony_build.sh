#!/bin/sh

# not volumed thru docker, so might need to manually create build/

if [[ -z "${SKIP_ANTIMONY}" ]]; then
    cd /home/antimony

    mkdir -p build install

    cd build

    echo configuring antimony...

    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install \
    -DWITH_SBML=ON -DWITH_STATIC_SBML=ON -DWITH_LIBSBML_LIBXML=ON -DWITH_PYTHON=ON \
    -DLIBSBML_INSTALL_DIR=/home/libsbml/install -DWITH_LIBSBML_COMPRESSION=ON \
    -DPYTHON_EXECUTABLE=$PYTHON_INTERP \
    -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE \
    -DWITH_QTANTIMONY=OFF -DWITH_CELLML=OFF -DPYTHON_LOCAL_INSTALL=ON -DPYTHON_SYSTEM_INSTALL=OFF \
    -DWITH_CONDA_BUILDER=OFF -DBZIP_LIBRARY=$BZIP2_LIB \
    -DLIBXML_LIBRARY=$LIBXML2_LIB -DZDLL_LIBRARY=$LIBZ_LIB \
    -DSWIG_EXECUTABLE=$SWIG_EXE ../source

    echo building antimony...
    make -j4

    echo installing...

    make install

    cd ../install/bindings/python
    python setup.py bdist_wheel
    cp dist/*.whl /io/

else
    echo NOTE: skipping antimony build. Nothing is installed.
fi

