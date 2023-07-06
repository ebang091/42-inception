
mkdir -p /etc/nginx/ssl/ \
			&& chmod 777 /etc/nginx/ssl

openssl req -newkey rsa:2048 -nodes -keyout /etc/nginx/ssl/nginx.pem -x509 -days 365 -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=${CONTRY_NAME}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/CN=${COMMON_NAME}"

chmod +r  /etc/nginx/ssl/nginx.pem 
chmod +r  /etc/nginx/ssl/nginx.crt