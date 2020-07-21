FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=nointeractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN apt update
RUN apt upgrade -y
RUN apt install -y --no-install-recommends rsyslog telnet nano net-tools inetutils-ping dnsutils cron tzdata sudo
RUN apt install -y --no-install-recommends postgresql apache2 libapache2-mod-passenger

COPY share/pg_hba.conf /etc/postgresql/12/main/pg_hba.conf
COPY share/sudo.conf /etc/sudo.conf
RUN chown postgres.postgres /etc/postgresql/12/main/pg_hba.conf

RUN service postgresql restart; \
	sudo -u postgres createuser -a -d -U postgres redmine; \
	sudo -u postgres psql -U postgres -c "alter user redmine with createdb encrypted password 'redmine'"; \
	apt install -y redmine-pgsql

COPY share/000-default.conf /etc/apache2/sites-available/000-default.conf

CMD /root/share/run.sh

