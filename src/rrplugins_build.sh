#!/bin/sh

if [[ -z "{SKIP_RRPLUGINS}" ]]; then
    echo NOTE: skipping tellurium build
else
    echo building tellurium plugins...

    cd /home/rrplugins/build

    echo configuring...

    cmake ../source -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/home/roadrunner/install \
        -DTLP_DEPENDENCIES_PATH=/home/roadrunner/install \
        -DTHIRD_PARTY_INSTALL_FOLDER=/home/roadrunner/install \
        -DLIBROADRUNNER_INCLUDE_DIR=/home/roadrunner/install/include \
        -DLIBROADRUNNERSTATIC_INCLUDE_DIR=/home/roadrunner/install/include

    echo building...
    make -j4
fi

# Install since this might be needed by rr
echo installing...
make install

