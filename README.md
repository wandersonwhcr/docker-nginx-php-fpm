# docker-nginx-php-fpm

Docker (+ Traefik) + NGINX + PHP-FPM = The Right Way

## Run

```
docker-compose up --detach
docker-compose exec php-fpm composer install

docker-compose up --detach \
    --scale nginx=3 \
    --scale php-fpm=3
```

## Production

```
docker build . --tag wandersonwhcr/hello
```
