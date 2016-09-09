Repo Info
=========
Build [Docker] image for [NGINX] provisioned via [Ansible]

Building
--------
If you need to modify any configurations you will need to rebuild the image:
```
docker build -t nginx .
```
And then spin the image up:
```
docker run -d -p 80:80 -p 443:443 nginx
```

Consuming
---------
```
docker run -d -p 80:80 -p 443:443 mrlesmithjr/nginx
```
You can also enable PHP support by spinning up as below:
```
docker run -d -e "NGINX_ENABLE_PHP=true" -p 80:80 -p 443:443 mrlesmithjr/nginx
```

Spin up using `docker-compose`:
```
docker-compose up -d
```

`docker-compose.yml`
```
version: '2'
services:
  nginx:
    environment:
      NGINX_ENABLE_PHP: "true"
    image: "mrlesmithjr/nginx"
    ports:
      - "80:80"
      - "443:443"
    restart: "always"
    volumes:
      - "nginx_www:/usr/share/nginx/www"

volumes:
  nginx_www:
```

The following [NGINX] `default` configuration is included:
```
server {
       	listen 80 default_server;
       	listen [::]:80 default_server;

       	root /var/www/html;

       	index index.html index.htm index.nginx-debian.html;

       	server_name _;

       	location / {
       		try_files $uri $uri/ =404;
       	}
{% if nginx_enable_php %}
       	location ~ \.php$ {
       	      	include snippets/fastcgi-php.conf;

       	      	fastcgi_pass unix:/run/php/php7.0-fpm.sock;
       	}
{% endif %}
}
```


License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- [@mrlesmithjr]
- [everythingshouldbevirtual.com]
- [mrlesmithjr@gmail.com]


[Ansible]: <https://www.ansible.com/>
[Docker]: <https://www.docker.com>
[NGINX]: <https://nginx.org/en/>
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
