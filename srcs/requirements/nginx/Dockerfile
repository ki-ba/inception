FROM alpine:3.22
# ENV TINI_VERSION=v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
# RUN chmod +x /tini
RUN apk add curl
RUN apk add nginx
RUN apk add openssl
# RUN mkdir -p /etc/nginx/ssl
# RUN touch /etc/nginx/ssl/inception.key
# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=login.42.fr/UID=login"
# RUN mkdir -p /var/run/nginx
# RUN rm -f /etc/nginx/nginx.conf
# COPY conf/nginx.conf /etc/nginx/nginx.conf
# RUN mkdir -p /var/www/html
# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html
# CMD [ "nginx", "-g", "daemon off;" ]
# ENTRYPOINT ["/tini", "--"]
