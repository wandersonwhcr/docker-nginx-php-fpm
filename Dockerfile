ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-fpm-alpine AS builder

ENV COMPOSER_CACHE_DIR /tmp

COPY --from=composer:2.0 /usr/bin/composer /usr/local/bin/composer

RUN apk add --no-cache unzip

COPY ./composer.* ./

RUN composer install --no-dev

COPY . .

RUN composer install --no-dev --optimize-autoloader --classmap-authoritative

FROM php:${PHP_VERSION}-fpm-alpine

COPY --from=builder /var/www/html /var/www/html

RUN apk add --no-cache fcgi \
    && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && curl --silent --remote-name https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/v0.5.0/php-fpm-healthcheck \
    && install --owner root --group root --mode 755 php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck \
    && rm -rf php-fpm-healthcheck \
    && find /usr/src -type f -name 'php*' -print -delete

HEALTHCHECK --interval=5s \
    CMD php-fpm-healthcheck || exit 1

USER www-data:www-data
