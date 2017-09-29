#!/bin/sh
docker run \
       --rm \
       -v $HOME/.m2:/home/user/.m2 \
       -v $(pwd):/usr/src/mysrc \
       -w /usr/src/mysrc \
       maven:3.3.9-jdk-8-alpine \
       mvn \
       -s /home/user/.m2/settings.xml \       
       -Duser.home=/home/user $*
