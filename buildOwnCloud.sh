#!/bin/bash

# By A.Ibrahim
# Build ownCloud docker environment through starting the docker image into a container using docker-compose. 
# For details:
# 	https://doc.owncloud.com/server/admin_manual/installation/docker/
#
# You can execute this file as normal user


LOG_FILE=./buildOwnCloud_out.log
SHOW_LOG_FILE="### Check Log out at $(readlink -f $LOG_FILE)  ###"

# Generate the database scripts
STEP_DESC="### Building ownCloud Containers ###"
echo $STEP_DESC
echo $SHOW_LOG_FILE

DOCKER_COMPOSE_FILE=./owncloud-docker-compose.yml

echo "# Build Docker containers"
#This file should be at the same folder with a docker-compose.yml file so we can start it.
#Configuration of the container should be reflected in the ".env" file at the same folder.
docker-compose -f $DOCKER_COMPOSE_FILE up -d >> $LOG_FILE

echo "## Building ownCoud Completed ##"
