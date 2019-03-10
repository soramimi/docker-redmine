#!/bin/sh
cd /var/www/redmine && RAILS_ENV=production bundle exec rake db:migrate
cd /var/www/redmine && RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data
