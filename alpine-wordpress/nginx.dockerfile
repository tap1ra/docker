FROM alpine:latest
MAINTAINER Yasuaki Tahira <yasuaki.tahira@gmail.com

# nginxの最新バージョンを指定
ENV NGINX_VERSION 1.9.14

# alpine3.3よりapk addに--no-cacheオプションが追加。rm -rf /var/cache/apk/* が不要になった
RUN apk add --no-cache --update pcre-dev openssl-dev \
  # --virtualオプションを使用しビルドのためだけに必要なパッケージ群はbuild-dependenciesというグループで定義し、削除をやりやすく
  && apk add --virtual build-dependencies build-base curl \
  && curl -SLO http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar xzvf nginx-${NGINX_VERSION}.tar.gz \
  && cd nginx-${NGINX_VERSION} \
  && ./configure \
       --sbin-path=/usr/local/sbin/nginx \
       --conf-path=/etc/nginx/nginx.conf \
  && make \
  && make install \
  && cd / \
  && apk del --purge build-dependencies \
  && rm -rf \
       nginx-${NGINX_VERSION} \
       nginx-${NGINX_VERSION}.tar.gz \
  && addgroup nginx \
  && adduser -S nginx -G nginx

ADD files/nginx.conf /etc/nginx/
ADD files/run-nginx.sh /
RUN chmod +x /run-nginx.sh

EXPOSE 80
VOLUME ["/DATA"]

CMD ["/run-nginx.sh"]
