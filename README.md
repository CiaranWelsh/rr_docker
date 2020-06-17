Here are some scripts for building/testing libRoadrunner Python wheels in manylinux2014 environment, using docker. Note
that for now this only supports Python 3.8, but it is trivial to add images to do this for other versions. See TODOs
below. This should work for any linux system with Docker, including WSL 2.

## Build steps

Building is very simple. One simply needs to run the docker scripts (described below). First, the build script looks for
roadrunner and libroadrunner-deps source code in this directory. You can edit `run.sh` to make docker look for the
source folders elsewhere. These are the two pertaining lines:

```
-v $(pwd)/roadrunner:/home/roadrunner/source \
-v $(pwd)/libroadrunner-deps:/home/libroadrunner-deps/source \
```

i.e. change it to `-v path/to/roadrunner/source:/home/roadrunner/source`, etc. Don't change the directory after the
colon, since it is a fixed mount point inside the docker container filesystem.

After this is done, simply run `build.sh` and then `run.sh` to build the wheels. If successful, the output wheel will be
in "out/". If something went wrong, you may run `exec.sh` to enter the container and continue build manually. A few things about
the filesystem:

* /home/ holds the build directories for llvm, roadrunner, and libroadrunner-deps. llvm has only an install folder since
it came with the `roadrunner_manylinux` image. In both roadrunner and deps there is an automated build script that you
can run.
* /io is the mounted directory for outputting wheels. Note that `/home/roadrunner/source` and
`/home/libroadrunner-deps/source` are both mount points too.
* the Python interpreter and build tools are in /opt. Check ~/.bashrc for full paths.

If when running `run.sh` there is error saying a container with the same name already exists, check out `docker rm`. 

## Build Settings

* By default roadrunner and deps and built with "make -j4". If you want to change that, you simply need to edit the
`rr_build.sh` and `deps_build.sh` scripts in `src` and run `build.sh` to rebuild the image.

## Docker Scripts

Here are the scripts for building the docker image and running the docker.

* ./build.sh builds the image by copying the build scripts from src/. Note that the build is based on
 the `evilnose/roadrunner_manylinux` image. To build *that* image one would need to manually build llvm, which
 would take a long time. So for now I've built the `roadrunner_manylinux` image manually, but in the future I would
 include code for building that.
* ./run.sh runs the code in docker for building libroadrunner-deps and roadrunner. It also installs it and tests it. If
successful, the output wheel would be copied to `out/`. This script does not remove the container automatically, so you
may use `docker rm` if you wish to delete it.
* ./exec.sh should be run after something fails. For example, if you successfully built libroadrunner-deps but not
roadrunner, and you don't want to rebuild the deps, you may run exec.sh to open a shell into the previous container, and
perform some build steps manually.

## Build Scripts

Scripts for building libroadrunner-deps, building roadrunner, and building and testing the Python wheels are in "src".
These scripts are copied into the docker filesystem during docker image build, and they are run inside the docker in the
roadrunner build step.

## Issues and TODOs

* For now I've manually installed bzip2, zlib, libxml2, and numpy using `yum install` in the `evilnose/roadrunner_manylinux`
image. This would make the image larger and less repreducible. The steps are a bit complex. I've included some notes on
how to reproduce that image in "notes.txt" for future reference.
* Also the Python version can be easily changed by modifying .bashrc to point to another Python interpretor.

