#!/bin/sh

ansible-playbook -i "localhost," -c local /docker-entrypoint.yml \
  --extra-vars "nginx_enable_php=$NGINX_ENABLE_PHP"

exec supervisord -n
