FROM php:8.0-fpm-alpine3.13 AS php_basic_env

RUN set -ex \
#    && echo https://dl-4.alpinelinux.org/alpine/v3.13/community/ >> /etc/apk/repositories \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache \
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
    && apk add --no-cache gnu-libiconv --update-cache --repository https://mirrors.ustc.edu.cn/alpine/edge/testing/ --allow-untrusted \
    && PKG_CONFIG_PATH=/usr/local docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp \
    && docker-php-ext-configure ldap \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install \
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
    # Memcached for 7.3 can currently only be built from master
#    && MEMCACHED="`mktemp -d`" \
#    && curl -skL https://github.com/php-memcached-dev/php-memcached/archive/master.tar.gz | tar xf - --strip-components 1 -C $MEMCACHED \
#    && docker-php-ext-configure $MEMCACHED \
#    && docker-php-ext-install $MEMCACHED \
#    && rm -rf $MEMCACHED \
    && pecl install apcu \
    && pecl install vips \
    && pecl install yaml \
    && pecl install redis \
    && pecl install mongodb \
    #&& pecl install imagick \
    #&& pecl install amqp \
    && pecl install xdebug \
    && docker-php-ext-enable \
        apcu \
        vips \
        yaml \
        redis \
        #imagick \
        mongodb \
#        openssl \
        #amqp \
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
        libmemcached-dev \
        yaml-dev \
    && rm -f /usr/local/etc/php-fpm.d/zz-docker.conf \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer2 \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer1 --1 \
    && ln -sf /usr/local/bin/composer2 /usr/local/bin/composer

WORKDIR /workdir/php

ADD conf/php.ini /usr/local/etc/php/php.ini

ADD conf/php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT ["php-fpm", "--nodaemonize"]
