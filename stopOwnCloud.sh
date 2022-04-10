#!/bin/bash

# By A.Ibrahim
# Stop ownCloud through stopping the docker image using docker-compose. 
# For details:
# 	https://docs.docker.com/compose/reference/stop/
#
# You can execute this file as normal user


LOG_FILE=./stopOwnCloud_out.log
SHOW_LOG_FILE="### Check Log out at $(readlink -f $LOG_FILE)  ###"

STEP_DESC="### Stopping ownCloud Containers ###"
echo $STEP_DESC
echo $SHOW_LOG_FILE


echo "# Stop Docker containers"
#This file should be at the same folder with a docker-compose.yml file so we can start it.
#Configuration of the container should be reflected in the ".env" file at the same folder.
docker-compose stop owncloud db redis >> $LOG_FILE

echo "## Stopping ownCoud Completed ##"
