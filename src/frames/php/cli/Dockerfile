FROM php:8.0-cli-alpine3.13

# OR `dl-cdn.alpinelinux.org`
ARG APK_REPO_HOST=mirrors.ustc.edu.cn
ARG EXT_PATH=/usr/src/custom_ext
# composer installer
ARG COMPOSER_INSTALLER=/usr/src/installer
# composer installer src
ARG COMPOSER_SRC=https://install.phpcomposer.com/installer
# exts version
# @see https://gitee.com/lotte2011/faster-source/tree/master/object
ARG V_EXT_AMQP=1.11.0beta
ARG V_EXT_MEMCACHED=master
ARG V_EXT_APCU=5.1.20
ARG V_EXT_VIPS=1.0.12
ARG V_EXT_YAML=2.2.1
ARG V_EXT_REDIS=5.3.4
ARG V_EXT_MONGODB=1.9.1
ARG V_EXT_XDEBUG=3.0.4

RUN set -ex \
# Custom::Prepare
  && sed -i "s/dl-cdn.alpinelinux.org/$APK_REPO_HOST/g" /etc/apk/repositories \
  && apk update \
  && apk add --no-cache git \
  && curl  -o $COMPOSER_INSTALLER -sS $COMPOSER_SRC \
  && cd /usr/src/ && mkdir -p $EXT_PATH && git clone --branch master --depth 1 https://gitee.com/lotte2011/faster-source.git source \
# PACKAGE::Install
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
  && apk add --no-cache gnu-libiconv --update-cache --repository https://$APK_REPO_HOST/alpine/edge/testing/ --allow-untrusted \
# Ext::Prepare
  && cd /usr/src/ \
  && tar xf source/object/php-amqp/$V_EXT_AMQP.tgz && mv amqp-$V_EXT_AMQP $EXT_PATH/amqp \
  && unzip source/object/php-memcached/$V_EXT_MEMCACHED.zip && mv php-memcached-$V_EXT_MEMCACHED $EXT_PATH/memcached \
  && tar xf source/object/php-apcu/$V_EXT_APCU.tgz && mv apcu-$V_EXT_APCU $EXT_PATH/apcu \
  && tar xf source/object/php-vips/$V_EXT_VIPS.tgz && mv vips-$V_EXT_VIPS $EXT_PATH/vips \
  && tar xf source/object/php-yaml/$V_EXT_YAML.tgz && mv yaml-$V_EXT_YAML $EXT_PATH/yaml \
  && tar xf source/object/php-redis/$V_EXT_REDIS.tgz && mv redis-$V_EXT_REDIS $EXT_PATH/redis \
  && tar xf source/object/php-mongodb/$V_EXT_MONGODB.tgz && mv mongodb-$V_EXT_MONGODB $EXT_PATH/mongodb \
  && tar xf source/object/php-xdebug/$V_EXT_XDEBUG.tgz && mv xdebug-$V_EXT_XDEBUG $EXT_PATH/xdebug \
# Ext::Configure
  && PKG_CONFIG_PATH=/usr/local docker-php-ext-configure intl \
  && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp \
  && docker-php-ext-configure $EXT_PATH/amqp \
  && docker-php-ext-configure $EXT_PATH/memcached \
  && docker-php-ext-configure $EXT_PATH/apcu \
  && docker-php-ext-configure $EXT_PATH/vips \
  && docker-php-ext-configure $EXT_PATH/yaml \
  && docker-php-ext-configure $EXT_PATH/redis \
  && docker-php-ext-configure $EXT_PATH/mongodb \
  && docker-php-ext-configure $EXT_PATH/xdebug \
  && docker-php-ext-configure ldap \
# Ext::Install
  && docker-php-ext-install \
    $EXT_PATH/amqp \
    $EXT_PATH/memcached \
    $EXT_PATH/apcu \
    $EXT_PATH/vips \
    $EXT_PATH/yaml \
    $EXT_PATH/redis \
    $EXT_PATH/mongodb \
    $EXT_PATH/xdebug \
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
# Ext::Enable
#  && docker-php-ext-enable \
#    apcu \
#    vips \
#    yaml \
#    redis \
#    mongodb \
#    amqp \
#    xdebug \
# PACKAGE::Clear
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
  && rm -f /usr/local/etca/php-fpm.d/zz-docker.conf \
# Composer::Install
  && php $COMPOSER_INSTALLER --install-dir=/usr/local/bin/ --filename=composer2 \
  && php $COMPOSER_INSTALLER --install-dir=/usr/local/bin/ --filename=composer1 --1 \
  && ln -sf /usr/local/bin/composer2 /usr/local/bin/composer \
# Custom::Clear
  && rm -rf /usr/src/source \
    /usr/src/package.xml \
    /usr/src/custom_ext \
    $COMPOSER_INSTALLER

ADD conf/php.ini /usr/local/etc/php/php.ini

ADD conf/php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

ADD conf/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
