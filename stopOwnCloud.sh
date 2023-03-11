#!/bin/bash

# By A.Ibrahim
# Stop ownCloud through stopping the docker image using docker-compose. 
# For details:
# 	https://docs.docker.com/compose/reference/stop/
#
# It was mentioned that stoping the mariadb without shutting down the database made the database
# corrupted. I had this problem when I tried to upgrade the owncloud from 10.5 to 10.11
# 
# When I tried to start mariadb after upgrade, the database keep restarting with the following
# error:
#  "InnoDB: Upgrade after a crash is not supported. The redo log was created with MariaDB 10.4.8. 
#  You must start up and shut down MariaDB 10.4 or earlier on the data directory."
# When I did that, It fixed the problem.
#
# Based on that, I modified this script to shutdown the database first before sstopping its container 
#
# Reference for this is the following:
#   https://serverfault.com/questions/661691/what-is-safe-way-to-stop-mysql-docker-container
# 
# You can execute this file as normal user
# This file should be at the same folder with a docker-compose.yml file so we can start it.
# Configuration of the container should be reflected in the ".env" file at the same folder.


LOG_FILE=./stopOwnCloud_out.log
SHOW_LOG_FILE="### Check Log out at $(readlink -f $LOG_FILE)  ###"

STEP_DESC="### Stopping ownCloud Containers ###"
echo $STEP_DESC
echo $SHOW_LOG_FILE

echo "# Stop owncloud containers"
docker-compose stop owncloud >> $LOG_FILE

echo "# Stop MariaDB database"
docker-compose exec mariadb  /usr/bin/mysqladmin -uroot -powncloud --wait-for-all-slaves shutdown

echo "# Stop Docker containers"
#This file should be at the same folder with a docker-compose.yml file so we can start it.
#Configuration of the container should be reflected in the ".env" file at the same folder.
docker-compose stop mariadb redis >> $LOG_FILE

echo "## Stopping ownCoud Completed ##"
