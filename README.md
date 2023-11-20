## *Install*

1. `sudo docker network create nginx-proxy`
2. `docker-compose build --no-cache`

## *Sample nginx app conifig*

```
version: '3.8'

services:
  nginx:
    image: nginx
    container_name: nginx-app-1
    expose:
      - "80"
    environment:
      - VIRTUAL_HOST=example.com,www.example.com,*.example.com # make sure you listed all your subdomains

networks:
  default:
    external:
      name: nginx-proxy
```

## *Sample nginx + php-fpm app conifig*

```
version: '3.8'

services:
  nginx:
    image: nginx
    container_name: nginx-app-1
    expose:
      - "80"
    environment:
      - VIRTUAL_HOST=example.com,www.example.com,*.example.com # make sure you listed all your subdomains
    networks:
      - nginx-proxy
      - internal

  php-fpm:
    container_name: php-fpm-app-1
    expose:
      - 9000
    hostname: example.com
    networks:
      - internal

networks:
  nginx-proxy:
    external:
      name: nginx-proxy
  internal: # it can be same name for all your apps
    driver: bridge
```

## *Sample nginx.conf*

```
server {
    listen 80;
    server_name localhost;
    index index.php index.html;
    root /var/www/html;

    # to see real user ip address
    set_real_ip_from 0.0.0.0/0;
    # other set_real_ip_from instruction, e.g. for cloduflare
    real_ip_header X-Forwarded-For;
    # make sure real_ip_recursive is on if you use other proxies, e.g. cloudflare
    real_ip_recursive on;
}
```

## *Run*

- `docker-compose up -d`

## *Shell*

- `docker exec -it nginx-proxy /bin/bash`
