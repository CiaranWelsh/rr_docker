FROM evilnose/roadrunner_manylinux2010:latest

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
# /home/bin for storing python version-invariant stuff
ENV PATH="${PYTHON_PATH}/bin:${TOOLS_PATH}:/home/bin:$PATH"

# this is necessary for manylinux2010, but need to be set of 2014
ENV LD_LIBRARY_PATH="/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:\
/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:\
/usr/local/lib64:/usr/local/lib"

ENV PYTHON_INTERP=${PYTHON_PATH}/bin/python
ENV PYTHON_INCLUDE=${PYTHON_PATH}/include/python3.${PYTHON3_MINOR_VERSION}${PY_SUFFIX}
ENV PYTHON_LIB=${PATH}/lib/python3.${PYTHON3_MINOR_VERSION}

ENV BZIP2_LIB=/usr/lib64/libbz2.so
ENV USR_INCLUDE=/usr/include/
ENV LIBXML2_LIB=/usr/lib64/libxml2.so
ENV LIBZ_LIB=/usr/lib64/libz.so
ENV SWIG_EXE=/usr/local/bin/swig

#RUN mkdir -p /home/scripts /home/rrplugins/source /home/rrplugins/build /home/antimony/source /home/antimony/build \
#        /home/libsbml-experimental/source /home/libsbml-experimental/build /home/libsbml-experimental/install \
#        /home/libsbml/source /home/libnuml/source /home/libnuml/build /home/libnuml/install \
#        /home/libsedml/source /home/libsedml/build /home/libsedml/install /home/phrasedml/source \
#        /home/phrasedml/build /home/phrasedml/install /home/libsbml/source /home/libsbml/build

VOLUME /io
VOLUME /home/libroadrunner-deps/source
VOLUME /home/libroadrunner-deps/build
VOLUME /home/roadrunner/source
VOLUME /home/roadrunner/build
VOLUME /home/rrplugins/source
VOLUME /home/rrplugins/build
VOLUME /home/antimony/source
VOLUME /home/libsbml/source
VOLUME /home/libsbml/build
VOLUME /home/libsbml-experimental/source
VOLUME /home/libsbml-experimental/build
VOLUME /home/libnuml/source
VOLUME /home/libsedml/source
VOLUME /home/phrasedml/source
# Don't bother with keeping the build directory for antimony, libnuml,
# libsedml, or phrasedml, since they take so little time

VOLUME /home/scripts/
VOLUME /home/setup_scripts/

# use the same cmake installation regardless of python version
RUN mkdir /home/bin
RUN /opt/python/cp38-cp38/bin/pip install cmake && \
        cp /opt/python/cp38-cp38/bin/cmake /home/bin/

RUN pip install numpy && \
    ln -s $PYTHON_PATH/lib/python3.${PYTHON3_MINOR_VERSION}/site-packages/numpy/core/include/numpy \
    $PYTHON_PATH/include/python3.${PYTHON3_MINOR_VERSION}${PYTHON_SUFFIX}/numpy

RUN yum install -y bzip2-devel libxml2-devel zlib-devel libxml2-static zlib-static pcre-devel

COPY src/swig_build.sh /home/scripts/swig_build.sh
RUN /home/scripts/swig_build.sh

# set timezone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#CMD home/scripts/deps_build.sh && \
#/home/scripts/rr_build.sh
#/home/scripts/rrplugins_build.sh && \
#CMD /home/scripts/build_wheel_and_test.sh && \
/home/scripts/libsbml_build.sh && \
/home/scripts/antimony_build.sh && \
#/home/scripts/libsbml-experimental_build.sh && \
#/home/scripts/libnuml_build.sh && \
#/home/scripts/libsedml_build.sh && \
#/home/scripts/phrasedml_build.sh && \
#/home/scripts/zipper_build.sh

