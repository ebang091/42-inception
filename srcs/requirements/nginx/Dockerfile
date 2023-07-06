FROM debian:bullseye

RUN 	apt-get -y update \
		&& apt-get -y install dumb-init

RUN 	apt-get -y install nginx openssl

RUN		mkdir -p /etc/nginx/ssl/ \
			&& chmod 777 /etc/nginx/ssl

COPY	tools/settings.sh  ./init.sh
RUN		chmod 777 ./init.sh 

RUN		mkdir -p /etc/nginx/ssl/ \
			&& chmod 777 /etc/nginx/ssl \
			&& openssl req -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/nginx.pem -x509 -days 365 -out /etc/nginx/ssl/nginx.crt \
				-subj "/C=${CONTRY_NAME}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/CN=${COMMON_NAME}"

COPY	conf/default /etc/nginx/sites-enabled/default

ENTRYPOINT ["/usr/bin/dumb-init"]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]