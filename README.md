Here are some scripts for building/testing libRoadrunner Python wheels in manylinux2010/manylinux2014 environment, using docker. This supports building for Python 3.5-3.8.

## Base image
All build starts off from a base image that contains precompiled LLVM-6.0.1 binaries. If you would not like to build it manually, you may pull the pre-built images
from (dockerhub)[https://hub.docker.com/repository/docker/evilnose/roadrunner_manylinux]. Modify the first line of Dockerfile to pull from
`evilnose/roadrunner_manylinux:latest` for manylinux2014, or `evilnose/roadrunner_manylinux:2010` for manylinux2010 (the 2010 image is not uploaded as of
this moment, but will be soon).

## Build steps

Building is very simple. One simply needs to run the docker scripts (described below). First, the build script looks for
sources in the `source` directory. You can edit `run.sh` to make docker look for the
source folders elsewhere, i.e. modify the line `SOURCES_DIR=$(pwd)/sources`. You can also modify the names of the individual
folders for each line that begins with "-v".

Note that some more volumes are created to temporarily store the build binaries, in case you want to reuse them after a failed build.

After this, enter `build.sh` and edit *only* the `PY_MINOR_VERSION` variable to set Python3 minor version.

Finally, you need to modify either the last line (one that starts with "CMD") to only execute the scripts you want to, or append
a command to the `docker run` call in "run.sh". See docker documentation for more info. For exmaple, if you want to build
roadrunner you would set "CMD" to
```
CMD /home/scripts/deps_build.sh && \
/home/scripts/roadrunner_build.sh
```
The build scripts are stored in "src", and they are volumed to "home/scripts" inside the container when docker runs. You may need to
run certain scripts before others due to dependency.

Now, simply run `build.sh` and then `run.sh` to build the wheels. If successful, the output wheel will be
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
* uncomment/comment the line `-e SKIP_RR_DEPS=1` in run.sh to skip/not skip building roadrunner-dependencies, etc.

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
These scripts are copied into the docker filesystem during docker image build ("/home/scripts"), and they are run inside the docker in the
roadrunner build step.

## Issues and TODOs

* For now the base image includes llvm binaries and directory structure by default. It would be good to have a project
that builds the base image so that we can reproduce it.

