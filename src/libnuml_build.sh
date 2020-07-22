# not volumed thru docker, so might need to manually create build/
mkdir -p /home/libnuml/build /home/libnuml/install
cd /home/libnuml/build

rm -rf *

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install \
-DLIBSBML_LIBRARY=/home/libsbml-experimental/install/lib64/libsbml-static.a \
-DLIBSBML_INCLUDE_DIR=/home/libsbml-experimental/install/include/ \
-DLIBSBML_STATIC=ON -DEXTRA_LIBS="xml2;bz2;z" -DWITH_CPP_NAMESPACE=ON -DWITH_PYTHON=ON \
-DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE \
-DPYTHON_LIBRARY=$PYTHON_LIB \
-DPYTHON_USE_DYNAMIC_LOOKUP=ON -DSWIG_EXECUTABLE=$SWIG_EXE ../source/libnuml

make -j4

make install

cd ../install

echo "from .libnuml import *" > lib/python3.${PY3_MINOR_VERSION}/site-packages/libnuml/__init__.py
cp /home/setup_scripts/libnuml_setup.py setup.py

python setup.py bdist_wheel
cp dist/*.whl /io/

