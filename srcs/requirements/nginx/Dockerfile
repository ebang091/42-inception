FROM debian:bullseye

RUN 	apt-get -y update \
		&& apt-get -y install dumb-init

RUN 	apt-get -y install nginx openssl \
		&& mkdir -p /etc/nginx/ssl/ \
		&& chmod 777 /etc/nginx/ssl

CONTRY_NAME=KR
STATE=Seoul
LOCALITY=Gaepodong
ORGANIZATION=42Seoul
COMMON_NAME=ebang.42.fr

RUN chmod 777 ./tools/settings.sh && sh ./tools/settings.sh
COPY	conf/default /etc/nginx/sites-enabled/default

ENTRYPOINT ["/usr/bin/dumb-init"]

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]