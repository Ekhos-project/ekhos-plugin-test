#!/bin/bash
# Exécuter PHPUnit
cd /var/www/html/ && phpunit

# Ensuite, exécuter le script d'entrée original d'Apache pour démarrer le serveur
exec docker-entrypoint.sh apache2-foreground
