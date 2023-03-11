#!/bin/bash

# By A.Ibrahim
# Backup ownCloud database as a preparation step for upgrading ownCloud. 
# For details:
# 	https://doc.owncloud.com/server/10.11/admin_manual/installation/docker/#upgrading-owncloud-on-docker
#
# You can execute this file as normal user
# This file should be at the same folder with a docker-compose.yml file so we can start it.
# Configuration of the container should be reflected in the ".env" file at the same folder.


LOG_FILE=./backupOwnCloudDB_out.log
SHOW_LOG_FILE="### Check Log out at $(readlink -f $LOG_FILE)  ###"

STEP_DESC="### Backup ownCloud DataBase ###"
echo $STEP_DESC
echo $SHOW_LOG_FILE

echo "# Enable Maintenance Mode"

docker-compose exec owncloud occ maintenance:mode --on

echo "# Start Backup DataBase"
docker-compose exec db \
    /usr/bin/mysqldump \
    -u root \
    --password=owncloud \
    --single-transaction \
    owncloud > owncloud_$(date +%Y%m%d).sql

echo "## Backup DataBase Completed ##"
