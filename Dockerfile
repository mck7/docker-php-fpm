FROM php:7.4-fpm
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
        libzip-dev \
        less \
        vim \
        curl \
        ca-certificates \
        sqlite3 \
        libsqlite3-dev \
        zsh \
        less

# Add all of the php specific packages
RUN docker-php-source extract \
    && docker-php-ext-configure gd \
        --with-freetype=/usr/include/ \
        --with-jpeg=/usr/include/ \
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

# Install modules not able to be installed any other way
RUN pecl install xdebug

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# Install WP CLI Tools
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp
#
# # Extra WP CLI Plugins
# RUN php -d memory_limit=512M "$(which wp)" --allow-root package install markri/wp-sec

# Server configuration overrides
ADD ./config/php.ini /usr/local/etc/php/conf.d/custom.ini

# Local administration environment overrides
ADD dotfiles/* /root/

# Set the workdir
WORKDIR /var/www/html
