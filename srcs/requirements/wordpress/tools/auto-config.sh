#!/bin/bash

# Read from docker secrets
SQL_PASSWORD=$(cat "$SQL_PASSWORD_FILE")
WD_ADM_USER=$(cat "$WD_ADM_USER_FILE")
WD_ADM_PASS=$(cat "$WD_ADM_PASS_FILE")
WD_ADM_MAIL=$(cat "$WD_ADM_MAIL_FILE")
WD_GUEST_USER=$(cat "$WD_GUEST_USER_FILE")
WD_GUEST_PASS=$(cat "$WD_GUEST_PASS_FILE")
WD_GUEST_MAIL=$(cat "$WD_GUEST_MAIL_FILE")

echo "Waiting..."

sleep 5

#   -z if empty
if [ -z "$SQL_DATABASE" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ]; then
    echo "Error: Required environment variables are not set."
    exit 1
fi
#-f check if exist
if [ -f "/var/www/html/wp-config.php" ]; then
    echo "WordPress configuration exists, skipping installation."
else
    echo "Downloading WordPress..."
    wp core download --path="/var/www/html" --locale=$WD_LANGUAGE --allow-root
    #Crée le fichier de configuration WordPress (wp-config.php) Utilisateur MySQL/MariaDB ($SQL_USER) :
    wp config create --path="/var/www/html" --allow-root --dbname="$SQL_DATABASE" --dbuser="$SQL_USER" --dbpass="$SQL_PASSWORD" --dbhost="mariadb:3306"
    # Installe WordPress
    echo "Installing WordPress..."
    wp core install --path="/var/www/html" --allow-root --url="$DOMAIN_NAME" --title="$SITE_TITLE" --admin_user="$WD_ADM_USER" --admin_password="$WD_ADM_PASS" --admin_email="$WD_ADM_MAIL"
    # Crée un utilisateur invité
    echo "Creating user..."
    wp user create "$WD_GUEST_USER" "$WD_GUEST_MAIL" --role="subscriber" --user_pass="$WD_GUEST_PASS" --allow-root --path="/var/www/html"
    echo "Successfully installed WordPress!"
fi

#Prépare le répertoire pour PHP-FPM
mkdir -p /run/php

echo "Wordpress is about to start"
# Lance PHP-FPM en mode foreground (-F) pour garder le conteneur actif
/usr/sbin/php-fpm7.4 -F