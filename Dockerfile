FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add nginx && \
    rm -rf /var/cache/apk/*

RUN mkdir /app && \
    mkdir /app/logs && \
    mkdir /app/logs/nginx

ADD resources/nginx.conf /app/resources/nginx.conf
ADD resources/entrypoint.sh /entrypoint.sh

EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
