FROM php:8.0-fpm-alpine AS builder

ENV COMPOSER_CACHE_DIR /tmp

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir /usr/bin --filename composer \
    && php -r "unlink('composer-setup.php');" \
    && apk add unzip \
    && find /usr/src -type f -print -delete

COPY ./composer.* ./

RUN composer install

COPY . .

FROM php:8.0-fpm-alpine

COPY --from=builder /var/www/html /var/www/html
