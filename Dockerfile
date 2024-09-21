# Utilisation de PHP avec FPM et Alpine
FROM php:8.3-fpm-alpine AS base

# Installation des extensions PHP nécessaires
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache

# Ajout du fichier de configuration d'OpCache
COPY opcache.ini $PHP_INI_DIR/conf.d/

# Installation des dépendances pour Composer et Git
RUN apk add --no-cache git unzip curl bash

# Téléchargement de Composer
COPY --from=composer:2.7.9 /usr/bin/composer /usr/local/bin/composer

# Configuration du dossier de travail
WORKDIR /var/www/html

# Utilisation d'une étape distincte pour Symfony CLI (facultatif)
# FROM base AS symfony-cli
# RUN wget https://get.symfony.com/cli/installer -O - | bash \
#     && mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Fin de l'image finale
