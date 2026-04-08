FROM alpine:3.22

# RUN apk add sh
RUN apk add mariadb mariadb-client
RUN rm -f /etc/init.d/mariadb /etc/init.d/mysql /etc/my.cnf /etc/mysql/my.cnf
COPY ./entrypoint.sh /usr/entrypoint.sh
COPY ./healthcheck.sh /usr/healthcheck.sh

RUN chmod +x /usr/entrypoint.sh
RUN chmod +x /usr/healthcheck.sh

EXPOSE 3306

ENTRYPOINT ["/usr/entrypoint.sh"]
