ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-fpm-alpine AS builder

ENV COMPOSER_CACHE_DIR /tmp

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN apk add unzip

COPY ./composer.* ./

RUN composer install --no-dev

COPY . .

RUN composer install --no-dev --optimize-autoloader --classmap-authoritative

FROM php:${PHP_VERSION}-fpm-alpine

COPY --from=builder /var/www/html /var/www/html

RUN find /usr/src -type f -name 'php*' -print -delete

USER www-data:www-data
