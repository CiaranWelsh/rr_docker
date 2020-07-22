#!/usr/bin/python3
"""
go thru wheels in the out/ directory, converting any file with the form
... -linux ... to ... -manylinux2014 ... Useful since manylinux2014 spits
out -linux wheels by default
"""
import os
from os import listdir
from os.path import isfile, join

OUT = './out'

files = [f for f in listdir(OUT) if isfile(join(OUT, f))]

for fname in files:
    newfname = fname.replace('-linux', '-manylinux2010')
    if fname == newfname:
        continue
    cmd = "mv {} {}".format(join(OUT, fname), join(OUT, newfname))
    print(cmd)
    os.system(cmd)


