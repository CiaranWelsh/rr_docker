#!/bin/bash

docker run -it --name rr_build_container \
    -v $(pwd)/out:/io \
    -v $(pwd)/roadrunner:/home/roadrunner/source \
    -v $(pwd)/libroadrunner-deps:/home/libroadrunner-deps/source \
    rr_build \

