#!/bin/sh

echo building dependencies...

# need to do this for linking, specific to docker
export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:\
/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:\
/usr/local/lib64:/usr/local/lib

# cleanup possible previous build and get ready
cd /home/libroadrunner-deps/
rm -rf build/*
cd build

echo configuring...
cmake ../source/ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../roadrunner/install

echo building...
make -j4

echo installing...
make install

