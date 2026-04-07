#!/bin/sh

mkdir -p /var/www/html/
cd /var/www/html
curl -O https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm latest.tar.gz

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
ls -la > /var/www/html/wordpress-ls
exec /usr/sbin/php-fpm82 -F
