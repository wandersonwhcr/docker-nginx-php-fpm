# docker-nginx-php-fpm

## Run

```
docker-compose up --detach
docker-compose exec php-fpm composer install
```

## Production

```
docker build . --tag wandersonwhcr/hello
```
