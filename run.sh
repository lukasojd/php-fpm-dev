#!/bin/bash

echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $3 }'` >> /etc/php/7.0/fpm/conf.d//xdebug.ini
echo "xdebug.remote_host="`/sbin/ip route|awk '/default/ { print $3 }'` >> /etc/php/7.0/cli/conf.d/xdebug.ini

exec php-fpm7.0 -F
