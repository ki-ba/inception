FROM alpine:3.22
# ENV TINI_VERSION=v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
# RUN chmod +x /tini

RUN apk add curl
RUN apk add nginx
RUN apk add openssl
RUN mkdir -p /etc/ssl/kbarru.42.fr
RUN openssl req -x509 -newkey rsa:2048 -days 3650 \
  -noenc -keyout /etc/ssl/kbarru.42.fr/kbarru.42.fr.key -out etc/ssl/kbarru.42.fr/kbarru.42.fr.crt -subj "/CN=kbarru.42.fr" \
  -addext "subjectAltName=DNS:kbarru.42.fr,DNS:*.kbarru.42.fr"

RUN mkdir -p /var/www/html

RUN rm -f /etc/nginx/nginx.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]
