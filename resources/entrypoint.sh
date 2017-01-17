#!/bin/sh -e

mkdir -p /www/logs
/usr/sbin/nginx -c /app/resources/nginx.conf -p /www
