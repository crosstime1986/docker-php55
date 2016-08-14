FROM php:5.5.38-fpm


RUN apt-get update  \
    && apt-get install -y libmemcached-dev \
    && apt-get install -y zlib1g-dev libjpeg-dev libpng-dev libfreetype6-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli \
    && groupadd -g 1001 www \
    && useradd -g 1001 -u 1001 -M -s /sbin/nologin www \
    && mkdir -p /app

COPY app/index.php /app/
COPY config/php.ini-production /usr/local/etc/php/php.ini


EXPOSE 9002
