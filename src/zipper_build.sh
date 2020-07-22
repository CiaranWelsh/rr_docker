#!/bin/bash

mkdir -p /home/zipper
cd /home/zipper

mkdir -p build install

git clone --recurse-submodules https://github.com/fbergmann/zipper.git

mv zipper source

cd build

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install -DLIBZ_LIBRARY=/usr/lib64/libz.so \
-DLIBZ_INCLUDE_DIR=/usr/include ../source

make -j4

make install

