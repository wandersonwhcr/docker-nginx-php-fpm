ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-fpm-alpine

ENV COMPOSER_CACHE_DIR /tmp

COPY --from=composer:2.0 /usr/bin/composer /usr/local/bin/composer

RUN apk add --no-cache fcgi unzip \
    && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf \
    && curl --silent --remote-name https://raw.githubusercontent.com/renatomefi/php-fpm-healthcheck/v0.5.0/php-fpm-healthcheck \
    && install --owner root --group root --mode 755 php-fpm-healthcheck /usr/local/bin/php-fpm-healthcheck \
    && rm -rf php-fpm-healthcheck
