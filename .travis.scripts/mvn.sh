#!/bin/sh
docker run \
       --rm \
       -v $HOME/.sonar/cache:$USER_HOME_DIR/.sonar/cache \
       -v $HOME/.m2:$USER_HOME_DIR/.m2 \
       -v $(pwd):/usr/src/mysrc \
       -w /usr/src/mysrc \
       maven:3.3.9-jdk-8-alpine \
       mvn \
       -Duser.home=$USER_HOME_DIR \
       --settings $USER_HOME_DIR/.m2/settings.xml \
       $*
