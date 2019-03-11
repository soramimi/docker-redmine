#!/bin/sh

export LANG=C

cp -a /var/www/redmine/db-migrate /var/www/redmine/db/migrate

service apache2 start

while :
do
	date
	sleep 1
done

