#!/bin/sh

echo building python wheel...

cd /home/roadrunner/install

python setup.py bdist_wheel

pip install dist/*.whl

python -c "import roadrunner; roadrunner.runTests()"

echo \nTests completed. Check output above to make sure if they passed.

# copy to output volume
cp dist/*.whl /io/

echo Output wheel copied to out/.

echo Done.

