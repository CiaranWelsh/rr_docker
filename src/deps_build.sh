#!/bin/sh

echo building dependencies...

# get into directory
cd /home/libroadrunner-deps/
cd build

if [[ -z "${SKIP_RR_DEPS}" ]]; then
    # not skipping; cleanup previous build and rebuild
    echo NOTE: rebuilding roadrunner dependencies...

    rm -rf *

    echo configuring...
    cmake ../source/ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../../roadrunner/install

    echo building...
    make -j4
else
    echo NOTE: skipping libroadrunner-deps build. Proceeding to installation...
fi

echo installing...
make install

