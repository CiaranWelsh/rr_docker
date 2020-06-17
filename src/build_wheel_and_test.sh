#!/bin/sh

echo building python wheel...

source ~/.bashrc

export LD_LIBRARY_PATH=/opt/rh/devtoolset-9/root/usr/lib64:/opt/rh/devtoolset-9/root/usr/lib:\
/opt/rh/devtoolset-9/root/usr/lib64/dyninst:/opt/rh/devtoolset-9/root/usr/lib/dyninst:\
/usr/local/lib64:/usr/local/lib

cd /home/roadrunner/install

python setup.py bdist_wheel

pip install dist/*.whl

python -c "import roadrunner; roadrunner.runTests()"

echo tests completed. Check output above to make sure if they passed.

# copy to output volume
cp dist/*.whl /io/

echo output wheel copied to out/.

echo Done.

