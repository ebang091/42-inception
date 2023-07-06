FROM	debian:bullseye

ARG		MYSQL_ROOT_PASSWORD
ARG 	WORDPRESS_DB_NAME
ARG 	WORDPRESS_DB_USER
ARG 	WORDPRESS_DB_PASSWORD

ENV		MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV		WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}
ENV		WORDPRESS_DB_USER=${WORDPRESS_DB_USER}
ENV		WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}

RUN 	apt-get -y update \
		&& apt-get -y install dumb-init
RUN		apt-get -y install mariadb-server mariadb-client \
		&& mkdir /run/mysqld \
		&& chmod 777 /run/mysqld \
		&& chmod 777 /var/lib/mysql \
		&& rm -rf /var/lib/mysql/aria_log_control

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/settings.sh ./init.sh

RUN		chmod 044 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN		chmod 755 ./init.sh

ENTRYPOINT	["/usr/bin/dumb-init", "--"]

CMD		["./init.sh"]