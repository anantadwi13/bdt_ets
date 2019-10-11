#!/bin/bash

sed -i "s/.*APP_NAME.*/APP_NAME=${APP_NAME}/" /var/www/pweb-reservasi/.env
sed -i "s/.*DB_HOST.*/DB_HOST=${DB_HOST}/" /var/www/pweb-reservasi/.env
sed -i "s/.*DB_PORT.*/DB_PORT=${DB_PORT}/" /var/www/pweb-reservasi/.env
sed -i "s/.*DB_DATABASE.*/DB_DATABASE=${DB_DATABASE}/" /var/www/pweb-reservasi/.env
sed -i "s/.*DB_USERNAME.*/DB_USERNAME=${DB_USERNAME}/" /var/www/pweb-reservasi/.env
sed -i "s/.*DB_PASSWORD.*/DB_PASSWORD=${DB_PASSWORD}/" /var/www/pweb-reservasi/.env

sleep 60

service apache2 restart

if  [ ! -f "/var/www/initialized" ]; then
    mysql -h 192.168.17.30 -u haproxy_root -padmin -e "CREATE DATABASE IF NOT EXISTS reservasi;"
    php artisan migrate --seed
    touch /var/www/initialized
fi