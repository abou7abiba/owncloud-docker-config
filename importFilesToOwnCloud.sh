#!/bin/bash

# By A.Ibrahim
# Start ownCloud through starting the docker image into a container using docker-compose. 
# For details:
# 	https://doc.owncloud.com/server/admin_manual/installation/docker/
#
# To import files to ownCloud you need to update the database of ownCloud after copying the files to a special path.
# 
# For the details about it you can find this article.
#	https://bartsimons.me/manually-add-files-to-owncloud/ 
# For details of files:scaan command  you can find it in the documentation:
# 	https://doc.owncloud.com/server/10.5/admin_manual/configuration/server/occ_command.html#file-operations
# 

echo "## Import MyBook HDD as www-data user ##"

#PATH=MyBook/04-Work/IBM
#PATH=MyWork/MyWork/Engagements
PATH=MyBook/02-Media/Family
USER_NAME=admin

# Scan all connected devices
#docker-compose exec owncloud occ files:scan --all

# Scan the specific location for specific user.
#In this example .. the path is as follows: --path=/<user>/files/<Path from mounted name>
docker-compose exec owncloud occ files:scan --path=/$USER_NAME/files/$PATH

echo "## Import MyBook HDD as www-data user Completed ##"
