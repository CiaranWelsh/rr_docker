#/bin/bash

CONT=tecombine_container_py38

docker start $CONT

docker exec -it $CONT /bin/bash

