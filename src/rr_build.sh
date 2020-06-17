#!/bin/sh
# no comments here since this file is similar to deps_build.sh

echo building roadrunner...

source ~/.bashrc

export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:\
/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:\
/usr/local/lib64:/usr/local/lib

cd /home/roadrunner/
rm -rf build/*
cd build

echo configuring...
cmake ../source -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install/ \
-DLLVM_CONFIG_EXECUTABLE=../../llvm/install/bin/llvm-config \
-DLIBSBML_LIBRARY=../install/lib64/libsbml.so \
-DLIBSBML_STATIC_LIBRARY=../install/lib64/libsbml-static.a \
-DTHIRD_PARTY_INSTALL_FOLDER=../install -DRR_USE_CXX11=OFF -DUSE_TR1_CXX_NS=OFF \
-DSWIG_DIR=/usr/local/share/swig/3.0.12/ \
-DSWIG_EXECUTABLE=/usr/local/bin/swig -DBUILD_PYTHON=ON \
-DPYTHON_EXECUTABLE=/opt/python/cp38-cp38/bin/python \
-DPYTHON_LIBRARY=/opt/python/cp38-cp38/lib/python3.8 \
-DPYTHON_INCLUDE_DIR=/opt/python/cp38-cp38/include/python3.8 \
-DLLVM_INSTALL_PREFIX=../../llvm/install

echo building...
make -j4

echo installing...
make install

