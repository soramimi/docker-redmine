#!/bin/sh

export LANG=C

service postgresql start
service apache2 start
chmod 666 /usr/share/redmine/instances/default/config/secret_key.txt
chmod 666 /usr/share/redmine/instances/default/config/database.yml
chmod 777 /var/cache/redmine/default/tmp

while :
do
	date
	sleep 1
done

