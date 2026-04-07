#!/bin/sh
set -e

DATADIR="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

mkdir -p /run/mysqld "$DATADIR" /etc/my.cnf.d
chown -R mysql:mysql /run/mysqld "$DATADIR"

rm -f /etc/my.cnf /etc/mysql/my.cnf

cat > /etc/my.cnf.d/docker.cnf << EOF
[mysqld]
bind-address=0.0.0.0
port=3306
datadir=/var/lib/mysql
socket=/run/mysqld/mysqld.sock
skip-networking=0
EOF

if [ ! -d "$DATADIR/mysql" ]; then
    echo "Initializing MariaDB..."
    mariadb-install-db --user=mysql --datadir="$DATADIR"

    echo "Starting temporary MariaDB..."
    mariadbd --user=mysql --datadir="$DATADIR" --socket="$SOCKET" --bind-address=0.0.0.0 --port=3306 &
    pid="$!"

    until mariadb --socket="$SOCKET" -e "SELECT 1" >/dev/null 2>&1; do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    mariadb --socket="$SOCKET" -uroot <<EOSQL
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

    mariadb-admin --socket="$SOCKET" -uroot -p"${MARIADB_ROOT_PASSWORD}" shutdown
    wait "$pid" || true
fi

echo "Starting MariaDB in foreground..."
exec mariadbd --console --user=mysql --datadir="$DATADIR" --socket="$SOCKET" --bind-address=0.0.0.0 --port=3306
