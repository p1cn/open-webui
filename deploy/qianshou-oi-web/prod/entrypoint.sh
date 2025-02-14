#!/bin/sh
exec /app/nginx_binary/nginx -c /app/infra-lottery-web/nginx/nginx.conf -g 'daemon off;'
