FROM	debian:bullseye

RUN 	apt-get -y update \
		&& apt-get -y install mariadb-client \
		&& apt-get -y install dumb-init 

RUN		apt-get -y install php7.4 php7.4-fpm php7.4-mysql curl \
		&& mkdir /run/php \
		&& chmod 777 /run/php \
		&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
		&& mkdir -p /var/www/html/wordpress

# COPY	conf/wp-config.php /var/www/html/wp-config.php
# COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY	tools/settings.sh ./init.sh
RUN		chmod 777 init.sh



ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["./init.sh"]