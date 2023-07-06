#!/bin/bash 

if [ ! -c /var/www/html/index.php ]; then
	SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
	STRING="put your unique phrase here"

	echo "${SALT}" > temp.txt

	wp core download --allow-root --path=${WP_PATH} --locale=en_US
	mv ${WP_PATH}wp-config-sample.php ${WP_PATH}${WP_FILE}

	sed -i "s/'database_name_here'/'${WORDPRESS_DB_NAME}'/g" ${WP_PATH}${WP_FILE}
	sed -i "s/'username_here'/'${WORDPRESS_DB_USER}'/g" ${WP_PATH}${WP_FILE}
	sed -i "s/'password_here'/'${WORDPRESS_DB_PASSWORD}'/g" ${WP_PATH}${WP_FILE}
	sed -i "s/'localhost'/'${WORDPRESS_DB_HOST}'/g" ${WP_PATH}${WP_FILE}

	
	grep -n "${STRING}" ${WP_PATH}${WP_FILE} | cut -d ':' -f 1 | tail -n 1 | \
	xargs -I {} sh -c 'sed -i "{}r temp.txt" ${WP_PATH}${WP_FILE}'
	echo $STRING | xargs -I {} sh -c 'sed -i "/{}/d" ${WP_PATH}${WP_FILE}'

	sed -i 's|^listen = /run/php/php7.4-fpm.sock|;&|' ${WWW_CONF_PATH}${WWW_CONF_FILE}
	sed -i '/;listen = \/run\/php\/php7.4-fpm.sock/a\listen = wordpress:9000' ${WWW_CONF_PATH}${WWW_CONF_FILE}
	
	echo ${WP_PATH} ${DOMAIN_NAME} ${WORDPRESS_TITLE} ${WORDPRESS_DB_USER} ${WORDPRESS_DB_PASSWORD} ${WORDPRESS_ADMIN_EMAIL}
	wp core install --allow-root --path=${WP_PATH} --url=${DOMAIN_NAME} --title=${WORDPRESS_TITLE} --admin_name=${WORDPRESS_DB_USER} --admin_password=${WORDPRESS_DB_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL}
	wp user create cadet cadet@42.fr --user_pass=1234 --role=subscriber --allow-root --path=${WP_PATH}
fi
wp cli update

chown www-data: /var/www/html/ -R

/usr/sbin/php-fpm7.4 -F