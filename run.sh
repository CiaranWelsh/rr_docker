#!/bin/bash

PY_MINOR_VERSION=6

#-v $SOURCES_DIR/build/antimony:/home/antimony/build \
SOURCES_DIR=$(pwd)/sources

docker run -it --name tecombine_container_py3$PY_MINOR_VERSION \
    -v $(pwd)/out:/io \
    -v $SOURCES_DIR/roadrunner:/home/roadrunner/source \
    -v $(pwd)/build/roadrunner:/home/roadrunner/build \
    -v $SOURCES_DIR/libroadrunner-deps:/home/libroadrunner-deps/source \
    -v $(pwd)/build/libroadrunner-deps:/home/libroadrunner-deps/build \
    -v $SOURCES_DIR/rrplugins:/home/rrplugins/source \
    -v $(pwd)/build/rrplugins:/home/rrplugins/build \
    -v $SOURCES_DIR/antimony-code/antimony:/home/antimony/source \
    -v $SOURCES_DIR/sbml-trunk/libsbml/:/home/libsbml/source \
    -v $(pwd)/build/libsbml/:/home/libsbml/build \
    -v $SOURCES_DIR/sbml-experimental/:/home/libsbml-experimental/source \
    -v $(pwd)/build/sbml-experimental/:/home/libsbml-experimental/build \
    -v $SOURCES_DIR/NuML/:/home/libnuml/source \
    -v $SOURCES_DIR/libSEDML/:/home/libsedml/source \
    -v $SOURCES_DIR/phrasedml-code/:/home/phrasedml/source \
    -v $(pwd)/src/:/home/scripts/ \
    -v $(pwd)/scripts/:/home/setup_scripts/ \
    -e SKIP_RR_DEPS=1 \
    -e SKIP_RR= \
    -e SKIP_RRPLUGINS= \
    -e SKIP_ANTIMONY= \
    -e SKIP_LIBSBML= \
     last2010_py3$PY_MINOR_VERSION /bin/bash -c "/home/scripts/libsbml_build.sh && /home/scripts/zipper_build.sh &&
     /home/scripts/tecombine_build.sh"
    #m2010_py3$PY_MINOR_VERSION /bin/bash -c "/home/scripts/libsbml_build.sh"

