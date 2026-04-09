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

if [ ! -L /usr/bin/wp ]; then
	ln -s /var/www/html/wp-cli.phar /usr/bin/wp 
fi

chmod +x /var/www/html/wp-cli.phar

# until php /usr/bin/wp db check --path=/var/www/html/wordpress --allow-root >/dev/null 2>&1; do
#   echo "Waiting for WordPress DB access..."
#   sleep 2
# done

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  echo "initializing wp-config..."
  php /usr/bin/wp config create \
    --path=/var/www/html/wordpress \
    --dbname="${MARIADB_DATABASE}" \
    --dbuser="${MARIADB_USER}" \
    --dbpass="${MARIADB_PASSWORD}" \
    --dbhost="mariadb:3306" \
    --allow-root


fi

if ! php /var/www/html/wp-cli.phar core is-installed --path=/var/www/html/wordpress --allow-root >/dev/null 2>&1; then
  echo "Installing wordpress..."
  php /usr/bin/wp core install \
    --path=/var/www/html/wordpress \
    --url="http://kbarru.42.fr" \
    --title="kibz" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASS}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --locale=fr_FR \
    --skip-email \
    --allow-root
  echo "Creating contributor..."
  php /usr/bin/wp user create eval no@than.ks \
    --path=/var/www/html/wordpress \
    --role=subscriber \
    --user_pass=${USER_PASSWORD}
fi

exec /usr/sbin/php-fpm82 -F
