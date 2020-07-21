#!/bin/sh
PGPASSWORD=redmine dropdb -U redmine redmine_default
PGPASSWORD=redmine createdb -U redmine redmine_default
PGPASSWORD=redmine pg_restore -U redmine -d redmine_default /root/share/data/redmine.sqlc
