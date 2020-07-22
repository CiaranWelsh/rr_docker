mkdir -p /home/swig
cd /home/swig
mkdir -p build install
git clone --depth 1 --branch v3.0.12 https://github.com/swig/swig.git
cd swig
./autogen.sh
./configure
make -j4
make install

