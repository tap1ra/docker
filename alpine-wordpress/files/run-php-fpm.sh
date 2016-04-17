#!/bin/sh

[ -f /run-pre.sh ] && /run-pre.sh

if [ ! -d /DATA/htdocs ] ; then
  mkdir -p /DATA/htdocs
  chown nginx:www-data /DATA/htdocs
fi

# start php-fpm
mkdir -p /DATA/logs/php-fpm
php-fpm -F
