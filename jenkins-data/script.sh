#/bin/bash

DATE=$(date +%H-%M-%S)
BACKUP=db-$DATE.sql

DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3

mysqldump -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/$BACKUP && \
echo "Taking your $BACKUP backup" 

