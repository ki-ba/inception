#!/bin/sh

mkdir -p /var/www/html/wp
cd /var/www/html
curl -O https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz -C wp
rm latest.tar.gz

chown -R lighttpd /var/www/html
ln -s /var/www/html/wp/ /var/www/localhost/htdocs/wordpress

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
exec /usr/sbin/php-fpm82 -F
