FROM evilnose/roadrunner_manylinux:py38

COPY src/deps_build.sh /home/libroadrunner-deps/build.sh
COPY src/rr_build.sh /home/roadrunner/build.sh
COPY src/build_wheel_and_test.sh /home/roadrunner/test.sh

#VOLUME out /io
#VOLUME libroadrunner-deps /home/libroadrunner-deps/source
#VOLUME roadrunner /home/roadrunner/source
VOLUME /io
VOLUME /home/libroadrunner-deps/source
VOLUME /home/roadrunner/source

CMD /home/libroadrunner-deps/build.sh && \
        /home/roadrunner/build.sh && \
        /home/roadrunner/test.sh

