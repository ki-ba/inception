FROM alpine:3.22

RUN apk add curl

RUN apk add php82-fpm
COPY ./entrypoint.sh /usr/entrypoint.sh
RUN chmod +x /usr/entrypoint.sh
ENTRYPOINT ["/usr/entrypoint.sh"]
