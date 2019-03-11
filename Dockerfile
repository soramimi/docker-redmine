FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=nointeractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y rsyslog telnet nano net-tools dnsutils cron tzdata
#RUN apt-get update
#RUN apt-get upgrade -y
RUN apt-get install -y inetutils-ping build-essential git ruby ruby-dev bundler
RUN apt-get install -y apache2 libapache2-mod-passenger
RUN apt-get install -y sqlite libsqlite3-dev imagemagick libmagick++-dev

COPY ./share/redmine-3.4.9.tar.gz /tmp/
RUN cd /var/www && tar zxvf /tmp/redmine-3.4.9.tar.gz
RUN cd /var/www && mv redmine-3.4.9 redmine

ADD share/configuration.yml /var/www/redmine/config/configuration.yml
ADD share/database.yml /var/www/redmine/config/database.yml
ADD share/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN cd /var/www/redmine && bundle install --without development test --path vendor/bundle
RUN cd /var/www/redmine && bundle exec rake generate_secret_token

RUN chown www-data:www-data /var/www/redmine -R
RUN mv /var/www/redmine/db/migrate /var/www/redmine/db-migrate
RUN ln -s /var/www/redmine/public /var/www/html/redmine

CMD /root/share/run.sh

