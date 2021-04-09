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

## Deployment

* Docker

```
docker network create hello

docker run \
    --detach \
    --hostname php-fpm \
    --name hello_php-fpm \
    --network hello \
    wandersonwhcr/hello

docker run \
    --detach \
    --hostname nginx \
    --name hello_nginx \
    --network hello \
    --volume `pwd`/docker-compose/nginx/templates:/etc/nginx/templates \
    nginx:1.19
```

* Kubernetes

```
kubectl apply --filename ./kubernetes/ --recursive
```
