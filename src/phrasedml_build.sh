mkdir -p /home/phrasedml/build /home/phrasedml/install

cd /home/phrasedml/build

rm -rf *

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install -DPHRASEDML_ENABLE_XPATH_EVAL=ON \
-DLIBSBML_LIBRARY=/home/libsbml-experimental/install/lib64/libsbml-static.a \
-DLIBSBML_INCLUDE_DIR=/home/libsbml-experimental/install/include -DBZIP_LIBRARY=/usr/lib64/libbz2.so \
-DLIBXML_LIBRARY=/usr/lib64/libxml2.so -DZDLL_LIBRARY=/usr/lib64/zlib.so -DEXTRA_LIBS="bz2;z;xml2" \
-DLIBNUML_LIBRARY=/home/libnuml/install/lib/libnuml.so -DLIBNUML_INCLUDE_DIR=/home/libnuml/install/include \
-DLIBSEDML_LIBRARY=/home/libsedml/install/lib64/libsedml.so -DLIBSEDML_INCLUDE_DIR=/home/libsedml/install/include \
-DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON_INTERP -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE -DPYTHON_LOCAL_INSTALL=ON \
-DPYTHON_SYSTEM_INSTALL=OFF -DSWIG_EXECUTABLE=$SWIG_EXE ../source

make -j4

make install

cd ../install/bindings/python/

python setup.py bdist_wheel
cp dist/*.whl /io/

