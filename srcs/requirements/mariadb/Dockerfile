FROM alpine:3.22

RUN apk add mariadb mariadb-client
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql
# RUN rc-service mariadb start
# RUN mariadb-secure-installation
