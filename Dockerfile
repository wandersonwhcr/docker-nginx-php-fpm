FROM php:8.0-fpm-alpine

ENV COMPOSER_CACHE_DIR /tmp

COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

RUN apk add unzip \
    && find '/usr/src' -type f -name 'php*' -print -delete

COPY ./composer.* ./

RUN composer install \
    && find /usr/bin/composer -print -delete \
    && apk del unzip

COPY . .

USER www-data:www-data
