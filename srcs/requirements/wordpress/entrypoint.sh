#!/bin/sh
set -e

mkdir -p /var/www/html
cd /var/www/html

if [ ! -d /var/www/html/wordpress ]; then
  curl -LO https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  rm latest.tar.gz
fi

if [ ! -f /var/www/html/wp-cli.phar ]; then
  curl -LO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
fi

chmod +x /var/www/html/wp-cli.phar

until nc -z mariadb 3306; do
  echo "Waiting for MariaDB..."
  sleep 2
done

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  php /var/www/html/wp-cli.phar config create \
    --path=/var/www/html/wordpress \
    --dbname="$MARIADB_DATABASE" \
    --dbuser="$MARIADB_USER" \
    --dbpass="$MARIADB_PASSWORD" \
    --dbhost="mariadb:3306" \
    --skip-check \
    --allow-root
fi

exec /usr/sbin/php-fpm82 -F
