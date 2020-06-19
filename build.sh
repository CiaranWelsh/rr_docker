#!/bin/bash

PY_MINOR_VERSION=7

# See Dockerfile for more details
if [ "$PY_MINOR_VERSION" == "8" ]; \
    then PY_SUFFIX=; \
    else PY_SUFFIX=m; \
fi 

docker build --build-arg PYTHON3_MINOR_VERSION=$PY_MINOR_VERSION \
    --build-arg PYTHON_SUFFIX=$PY_SUFFIX \
    --tag rr_build .

