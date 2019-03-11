#!/bin/sh

export LANG=C

service apache2 start

while :
do
	date
	sleep 1
done

