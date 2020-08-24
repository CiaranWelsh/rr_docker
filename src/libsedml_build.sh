
mkdir -p /home/libsedml/build /home/libsedml/install

cd /home/libsedml/build

rm -rf *

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install \
-DLIBSBML_LIBRARY=/home/libsbml-experimental/install/lib64/libsbml-static.a \
-DLIBSBML_INCLUDE_DIR=/home/libsbml-experimental/install/include \
-DLIBSBML_STATIC=ON -DEXTRA_LIBS="xml2;bz2;z" -DWITH_CPP_NAMESPACE=ON -DWITH_PYTHON=ON \
-DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_USE_DYNAMIC_LOOKUP=ON \
-DLIBNUML_LIBRARY=/home/libnuml/install/lib/libnuml-static.a -DLIBNUML_INCLUDE_DIR=/home/libnuml/install/include \
-DSWIG_EXECUTABLE=$SWIG_EXE ../source

make -j4

make install

cd ../install

cp /home/setup_scripts/libsedml_setup.py setup.py

echo "from .libsedml import *" > lib64/python3.${PY3_MINOR_VERSION}/site-packages/libsedml/__init__.py

python setup.py bdist_wheel

cp dist/*.whl /io/

