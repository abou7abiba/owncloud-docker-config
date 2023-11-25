#!/bin/bash

# By A.Ibrahim
# Start ownCloud through starting the docker image into a container using docker-compose start. 
# For details:
# 	https://docs.docker.com/compose/reference/start/
#
# You can execute this file as normal user


LOG_FILE=./startOwnCloud_out.log
SHOW_LOG_FILE="### Check Log out at $(readlink -f $LOG_FILE)  ###"

STEP_DESC="### Starting ownCloud Containers ###"
echo $STEP_DESC
echo $SHOW_LOG_FILE


echo "# Start Docker containers"
#This file should be at the same folder with a docker-compose.yml file so we can start it.
#Configuration of the container should be reflected in the ".env" file at the same folder.
docker-compose start redis mariadb owncloud >> $LOG_FILE

echo "## Starting ownCoud Completed ##"
