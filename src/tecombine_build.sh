mkdir -p /home/tecombine/build/ /home/tecombine/install
cd /home/tecombine
git clone https://github.com/sbmlteam/libCombine.git
mv libCombine source
cd build

# temp; delete me - Gary
PYTHON_LIB=${PYTHON_PATH}/lib/python3.${PY3_MINOR_VERSION}

cmake -DLIBSBML_LIBRARY=/home/libsbml/install/lib64/libsbml-static.a -DLIBSBML_INCLUDE_DIR=/home/libsbml/install/include \
-DEXTRA_LIBS="xml2;bz2;z" -DZIPPER_INCLUDE_DIR=/home/zipper/install/include \
-DZIPPER_LIBRARY=/home/zipper/install/lib/libZipper-static.a -DPYTHON_LIBRARY=$PYTHON_LIB \
-DCMAKE_INSTALL_PREFIX=../install -DWITH_PYTHON=ON -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE \
-DPYTHON_EXECUTABLE=$PYTHON_INTERP ../source

make -j4

make install

cd ../install

echo "from .libcombine import *" > lib/python3.${PY3_MINOR_VERSION}/site-packages/libcombine/__init__.py

cp /home/setup_scripts/tecombine_setup.py setup.py

python setup.py bdist_wheel

cp dist/*.whl /io/

