FROM php:8.0-fpm-alpine

ENV COMPOSER_CACHE_DIR /tmp

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir /usr/bin --filename composer \
    && php -r "unlink('composer-setup.php');" \
    && apk add unzip \
    && find /usr/src -type f -print -delete

COPY ./composer.* ./

RUN composer install \
    && find /usr/bin/composer -print -delete \
    && apk del unzip

COPY . .

USER www-data:www-data
