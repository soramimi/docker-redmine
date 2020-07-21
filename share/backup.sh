#!/bin/sh
rm -fr /root/share/data
mkdir -p /root/share/data
PGPASSWORD=redmine pg_dump -U redmine -Fc --file=/root/share/data/redmine.sqlc redmine_default
tar zcvf /root/share/data/files.tar.gz -C /var/lib/redmine/default files
chown nobody.nogroup /root/share/data -R
chmod 777 /root/share/data
chmod 666 /root/share/data/*
