#!/bin/sh
rm /var/www/redmine/db/migrate -fr
mv /var/www/redmine/db-migrate /var/www/redmine/db/migrate
cd /var/www/redmine && RAILS_ENV=production bundle exec rake db:migrate
cd /var/www/redmine && RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
chown www-data.www-data /var/www/redmine -R
service apache2 restart
