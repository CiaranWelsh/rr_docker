mkdir -p /home/sbml2matlab
cd /home/sbml2matlab
mkdir -p build install
git clone https://github.com/sys-bio/sbml2matlab.git
mv sbml2matlab source
cd build

SBML_INSTALL=/home/libsbml/install

cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install \
-DLIBSBML_PREFIX=$SBML_INSTALL -DLIBSBML_STATIC_LIBRARY=${SBML_INSTALL}/lib64/libsbml-static.a \
-DLIBSBML_INCLUDE_DIR=${SBML_INSTALL}/include -DWITH_LIBSBML_COMPRESSION=ON -DEXTRA_LIBS="bz2;z;xml2" \
-DSWIG_EXECUTABLE=$SWIG_EXE -DLIBXML_LIBRARY=/usr/lib64/libxml2.so -DZDLL_LIBRARY=/usr/lib64/libz.so \
-DBZIP_LIBRARY=/usr/lib64/libbz2.so -DWITH_PYTHON=ON -DPYTHON_EXECUTABLE=$PYTHON_INTERP \
-DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE ../source

