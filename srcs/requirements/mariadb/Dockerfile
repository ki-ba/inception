FROM alpine:3.22

# RUN apk add sh
RUN apk add mariadb mariadb-client
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql
# RUN mariadb-secure-installation

COPY ./entrypoint.sh /usr/entrypoint.sh
RUN chmod +x /usr/entrypoint.sh
ENTRYPOINT ["/usr/entrypoint.sh", "--"]
