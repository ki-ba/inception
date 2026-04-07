FROM alpine:3.22

RUN apk add --no-cache \
curl \
php82 \
php82-fpm \
php82-mysqli \
netcat-openbsd \
php82-phar

RUN ln -s /usr/bin/php82 /usr/bin/php
RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf

COPY ./entrypoint.sh /usr/entrypoint.sh
RUN chmod +x /usr/entrypoint.sh

ENTRYPOINT ["/usr/entrypoint.sh"]
