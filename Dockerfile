FROM evilnose/roadrunner_manylinux:latest

# NOTE that not only do you need to modify this, you also need to modify
# the PYTHON_PATH env variable below. This can be improved later with
# some conditional code
ARG PYTHON3_MINOR_VERSION

# For Python 3.5/6/7 the path is /opt/python/cp35-cp35m
# But for Python 3.8 the path is /opt/python/cp38-cp38
# So this is a "private" argument set in the build script (either m or '')
ARG PYTHON_SUFFIX

ENV PY3_MINOR_VERSION=$PYTHON3_MINOR_VERSION
ENV PY_SUFFIX=$PYTHON_SUFFIX

ENV PYTHON_PATH=/opt/python/cp3${PYTHON3_MINOR_VERSION}-cp3${PYTHON3_MINOR_VERSION}${PYTHON_SUFFIX}
ENV TOOLS_PATH="/opt/rh/devtoolset-9/root/bin/"
ENV PATH="${PYTHON_PATH}/bin:${TOOLS_PATH}:$PATH"

ENV LD_LIBRARY_PATH="/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:\
/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:\
/usr/local/lib64:/usr/local/lib"

VOLUME /io
VOLUME /home/libroadrunner-deps/source
VOLUME /home/roadrunner/source

COPY src/deps_build.sh /home/libroadrunner-deps/build.sh
COPY src/rr_build.sh /home/roadrunner/build.sh
COPY src/build_wheel_and_test.sh /home/roadrunner/test.sh

RUN pip install cmake

RUN pip install numpy && \
    ln -s $PYTHON_PATH/lib/python3.${PYTHON3_MINOR_VERSION}/site-packages/numpy/core/include/numpy \
    $PYTHON_PATH/include/python3.${PYTHON3_MINOR_VERSION}${PYTHON_SUFFIX}/numpy

RUN yum install -y bzip2-devel libxml2-devel zlib-devel

CMD /home/libroadrunner-deps/build.sh && \
    /home/roadrunner/build.sh && \
    /home/roadrunner/test.sh

