FROM alpine:latest

RUN apk update \
    && apk add --no-cache nginx ca-certificates \
    && apk add -u musl

RUN sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd && \
    sed -i 's/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/sbin\/nologin/nginx:x:100:101:Linux User,,,:\/var\/www\/localhost\/htdocs:\/bin\/bash/g' /etc/passwd-

ADD files/nginx.conf /etc/nginx/
ADD files/run-nginx.sh /
RUN chmod +x /run-nginx.sh

EXPOSE 80
VOLUME ["/DATA"]

CMD ["/run-nginx.sh"]
