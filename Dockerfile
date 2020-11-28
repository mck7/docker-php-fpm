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
        zip \
        less \
        vim \
        curl \
        ca-certificates \
        sqlite3 \
        libsqlite3-dev \
        less \
        git

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

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# Configure composer
RUN export COMPOSER_ALLOW_SUPERUSER=1 \
  && composer global init \
  && composer global require hirak/prestissimo

# Wordpress CLI tools
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/wp

# Extra WP CLI Plugins
RUN php -d memory_limit=512M "$(which wp)" --allow-root package install markri/wp-sec

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
ADD dotfiles/* /root/
ADD config/php.ini /usr/local/etc/php/conf.d/custom.ini

ENV TERM xterm-256color
ENV POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD true
