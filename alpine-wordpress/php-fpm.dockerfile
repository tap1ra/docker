FROM alpine:latest

RUN apk update \
    && apk add --no-cache \
    php-fpm php-json php-zlib php-xml php-pdo php-phar php-openssl \
    php-pdo_mysql php-mysqli \
    php-gd php-iconv php-mcrypt \
    php-mysql php-curl php-opcache php-ctype php-apcu \
    php-intl php-bcmath php-dom php-xmlreader mysql-client && apk add -u musl \
    && addgroup nginx \
    && adduser -S nginx -G nginx

ENV TERM="xterm" \
    DB_HOST="172.17.0.1" \
    DB_NAME="wp" \
    DB_USER="test"\
    DB_PASS="test"

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/php.ini

ADD files/php-fpm.conf /etc/php/
ADD files/run-php-fpm.sh /
RUN chmod +x /run-php-fpm.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli

EXPOSE 9000
VOLUME ["/DATA"]

CMD ["/run-php-fpm.sh"]
