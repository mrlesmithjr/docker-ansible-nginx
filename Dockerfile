FROM mrlesmithjr/alpine-ansible

MAINTAINER Larry Smith Jr. <mrlesmithjr@gmail.com>

# Define Environment Vars
ENV NGINX_ENABLE_PHP="false"

# Copy Ansible Related Files
COPY config/ansible/ /

# Run Ansible playbook
RUN ansible-playbook -i "localhost," -c local /playbook.yml \
  --extra-vars "nginx_enable_php=$NGINX_ENABLE_PHP" && \
  rm -rf /tmp/* && \
  rm -rf /var/cache/apk/*

# Copy Docker Entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY config/supervisord/*.ini /etc/supervisor.d/

# Expose ports
EXPOSE 80 443

VOLUME ["/usr/share/nginx/www"]
