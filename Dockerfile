FROM debian:stretch

MAINTAINER Lukáš Kříž <lukasojd@gmail.com>

RUN apt-get update && apt-get install -y php7.0-common php7.0-sqlite php7.0-cli php7.0-fpm php7.0-mcrypt php7.0-mysql php7.0-gd php7.0-curl php7.0-intl php-memcache php-xdebug php7.0-xml php7.0-xmlrpc

ADD application.ini /etc/php/7.0/fpm/conf.d/
ADD application.ini /etc/php/7.0/cli/conf.d/

RUN rm /etc/php/7.0/fpm/pool.d/www.conf
RUN rm /etc/php/7.0/fpm/php-fpm.conf

ADD php-fpm.conf /etc/php/7.0/fpm/

RUN usermod -u 1000 www-data

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/lib/php/sessions/ && chown www-data:www-data /var/lib/php/sessions/

ADD xdebug.ini /etc/php/7.0/fpm/conf.d/
ADD xdebug.ini /etc/php/7.0/cli/conf.d/
ADD run.sh /

RUN chmod +x /run.sh

VOLUME ["/var/lib/php/sessions/"]

CMD /run.sh

EXPOSE 9000
