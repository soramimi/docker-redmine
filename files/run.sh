#!/bin/sh

export LANG=C

chown www-data.www-data /var/www/redmine -R

service apache2 start

while :
do
	date
	sleep 1
done

