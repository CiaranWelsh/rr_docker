#!/bin/sh
# no comments here since this file is similar to deps_build.sh

echo building roadrunner...

cd /home/roadrunner/
mkdir -p build install
cd build

if [[ -z "${SKIP_RR}" ]]; then
    echo NOTE: rebuilding roadrunner...

    rm -rf *

    echo configuring...
    cmake ../source -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install/ \
    -DLLVM_CONFIG_EXECUTABLE=../../llvm/install/bin/llvm-config \
    -DLIBSBML_LIBRARY=../install/lib64/libsbml.so \
    -DLIBSBML_STATIC_LIBRARY=../install/lib64/libsbml-static.a \
    -DTHIRD_PARTY_INSTALL_FOLDER=../install -DRR_USE_CXX11=OFF -DUSE_TR1_CXX_NS=OFF \
    -DSWIG_DIR=/usr/local/share/swig/3.0.12/ \
    -DSWIG_EXECUTABLE=/usr/local/bin/swig -DBUILD_PYTHON=ON \
    -DPYTHON_EXECUTABLE=$PYTHON_PATH/bin/python \
    -DPYTHON_LIBRARY=$PYTHON_PATH/lib/python3.${PY3_MINOR_VERSION} \
    -DPYTHON_INCLUDE_DIR=$PYTHON_PATH/include/python3.${PY3_MINOR_VERSION}${PY_SUFFIX} \
    -DLLVM_INSTALL_PREFIX=../../llvm/install

    echo building...
    make -j4

    echo installing...
    make install

    echo building python wheel...
    cd ../install

    echo stripping...

    strip lib/*.so
    strip lib/*.a

    strip site-packages/roadrunner/*.so*

    python setup.py bdist_wheel

    pip install dist/*.whl

    python -c "import roadrunner; roadrunner.runTests()"

    echo \nTests completed. Check output above to make sure if they passed.

    # copy to output volume
    cp dist/*.whl /io/

    echo Output wheel copied to out/.

    echo Done.
else
    echo NOTE: skipping roadrunner build. Nothing is installed.
fi

