FROM wordpress:php8.0-apache

RUN apt-get update && apt-get install -y \
        git \
        unzip \
        libzip-dev \
        zlib1g-dev \
        libpq-dev

RUN docker-php-ext-install zip

# Spécifiez la version de Xdebug compatible avec PHP 8.0 si nécessaire
RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN { \
        echo 'xdebug.mode=coverage'; \
        echo 'xdebug.start_with_request=trigger'; \
        echo 'xdebug.client_host=host.docker.internal'; \
        echo 'xdebug.client_port=9003'; \
    } > /usr/local/etc/php/conf.d/xdebug.ini

# Installez Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiez le fichier composer.json dans l'image
COPY composer.json /var/www/html/composer.json

COPY phpunit.xml /var/www/html/phpunit.xml

COPY .htaccess /var/www/html/.htaccess

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

# Exécutez Composer Install pour installer les dépendances PHP
RUN composer install --working-dir=/var/www/html

RUN ln -s /var/www/html/vendor/bin/phpunit /usr/local/bin/phpunit

# Définition du script comme point d'entrée
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
