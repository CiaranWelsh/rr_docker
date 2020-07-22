mkdir -p /home/tecombine/build/ /home/tecombine/install
cd /home/tecombine
git clone https://github.com/sbmlteam/libCombine.git
mv libCombine source
cd build

cmake -DLIBSBML_LIBRARY=/home/libsbml/install/lib64/libsbml.so -DLIBSBML_INCLUDE_DIR=/home/libsbml/install/include \
-DEXTRA_LIBS="xml2;bz2;z" -DZIPPER_INCLUDE_DIR=/home/zipper/install/include \
-DZIPPER_LIBRARY=/home/zipper/install/lib/libZipper-static.a \
-DCMAKE_INSTALL_PREFIX=../install ../source

make -j4

make install

