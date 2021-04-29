FROM php:8.0-fpm-alpine3.13

RUN set -ex \
#    && echo https://dl-4.alpinelinux.org/alpine/v3.13/community/ >> /etc/apk/repositories \
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && apk update \
  && apk add --no-cache \
    zlib-dev \
    cyrus-sasl-dev \
    oniguruma-dev \
    libmcrypt-dev \
    bash \
    ca-certificates \
    openssl \
    shadow \
    zip \
    unzip \
    bzip2 \
    drill \
    ldns \
    openssh-client \
    rsync \
    patch \
    git \
    # Install php environment
    imagemagick \
    graphicsmagick \
    ghostscript \
    jpegoptim \
    pngcrush \
    optipng \
    pngquant \
    vips \
    rabbitmq-c \
    c-client \
    # Libraries
    libldap \
    icu-libs \
    libintl \
    libpq \
    libxslt \
    libzip \
    libmemcached \
    yaml \
    # Build dependencies
    autoconf \
    g++ \
    make \
    libtool \
    pcre-dev \
    gettext-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    vips-dev \
    krb5-dev \
    openssl-dev \
    imap-dev \
    imagemagick-dev \
    rabbitmq-c-dev \
    openldap-dev \
    icu-dev \
    postgresql-dev \
    libxml2-dev \
    ldb-dev \
    pcre-dev \
    libxslt-dev \
    libzip-dev \
    libmemcached-dev \
    yaml-dev \
  # Memcached for 7.3
  && git clone -b master https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && docker-php-ext-configure /usr/src/php/ext/memcached \
  && docker-php-ext-install /usr/src/php/ext/memcached \
  && rm -rf /usr/src/php/ext/memcached \
#
  && apk add --no-cache gnu-libiconv --update-cache --repository https://mirrors.ustc.edu.cn/alpine/edge/testing/ --allow-untrusted \
  && PKG_CONFIG_PATH=/usr/local docker-php-ext-configure intl \
  && docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp \
  && git clone --branch master --depth 1 https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
  && cd /usr/src/php/ext/amqp && git submodule update --init \
  && docker-php-ext-configure ldap \
  && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-install \
    amqp \
    bcmath \
    bz2 \
    calendar \
    exif \
    ffi \
    intl \
    gettext \
    ldap \
    mysqli \
    imap \
    pcntl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    tokenizer \
    sysvmsg \
    sysvsem \
    sysvshm \
    shmop \
    xsl \
    zip \
    gd \
    gettext \
    opcache \
  # Other exts
  && pecl channel-update pecl.php.net \
  && pecl install apcu \
  && pecl install vips \
  && pecl install yaml \
  && pecl install redis \
  && pecl install mongodb \
#  && pecl install amqp \
  && pecl install xdebug \
  && docker-php-ext-enable \
    apcu \
    vips \
    yaml \
    redis \
    mongodb \
    amqp \
  && docker-php-ext-enable xdebug \
  # Uninstall dev and header packages
  && apk del -f --purge \
    autoconf \
    g++ \
    make \
    libtool \
    pcre-dev \
    gettext-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    vips-dev \
    krb5-dev \
    openssl-dev \
    imap-dev \
    rabbitmq-c-dev \
    imagemagick-dev \
    openldap-dev \
    icu-dev \
    postgresql-dev \
    libxml2-dev \
    ldb-dev \
    pcre-dev \
    libxslt-dev \
    libzip-dev \
    yaml-dev \
    libmemcached-dev \
    zlib-dev \
    cyrus-sasl-dev \
  && rm -f /usr/local/etc/php-fpm.d/zz-docker.conf \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer2 \
  && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer1 --1 \
  && ln -sf /usr/local/bin/composer2 /usr/local/bin/composer

WORKDIR /workdir/php

ADD conf/php.ini /usr/local/etc/php/php.ini

ADD conf/php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT ["php-fpm", "--nodaemonize"]
