#/bin/bash

CONT=strip_container_py37

docker start $CONT

docker exec -it $CONT /bin/bash

