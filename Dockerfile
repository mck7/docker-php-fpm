FROM php:7.2-fpm
MAINTAINER Cory Collier <corycollier@corycollier.com>

# Do all of the global system package installations
RUN apt -y update \
    && apt -y install \
        libpng-dev \
        libgmp-dev \
        zlib1g-dev \
        libfreetype6-dev \
    		libjpeg62-turbo-dev \
    		libmcrypt-dev \
        libxslt-dev \
        libjpeg-dev \
        libcurl3 \
        less \
        vim \
        curl \
        ca-certificates \
        sqlite3 \
        libsqlite3-dev \
        less

# Add all of the php specific packages
RUN docker-php-source extract \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --enable-gd-jis-conv \
    && docker-php-ext-install \
        gmp \
        bcmath \
        exif \
        gd \
        mysqli \
        pcntl \
        pdo \
        pdo_mysql \
        pdo_sqlite \
        xsl \
        zip

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN export COMPOSER_ALLOW_SUPERUSER=1 &&  composer global init

# Server configuration overrides
ADD ./config/php.ini /usr/local/etc/php/conf.d/custom.ini

# extra composer packages
RUN wp --allow-root package install markri/wp-sec

# Local administration environment overrides
ADD config/.vimrc /root/.vimrc
ADD config/.bashrc /root/.bashrc

# Set the workdir
WORKDIR /var/www/html
