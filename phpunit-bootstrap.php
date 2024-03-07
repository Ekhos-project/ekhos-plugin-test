<?php
define('ABSPATH', '/var/www/html/');

// Simulation de la constante WP_CONTENT_URL nécessaire pour plugin_dir_url()
define('WP_CONTENT_URL', 'http://example.com/wp-content');

// Inclut les fichiers WordPress nécessaires
require_once ABSPATH . 'wp-includes/functions.php';
require_once ABSPATH . 'wp-includes/plugin.php';
require_once ABSPATH . 'wp-includes/link-template.php';

// Simule la fonction bloginfo() si nécessaire
if (!function_exists('bloginfo')) {
    function bloginfo($show='') {
        switch ($show) {
            case 'url':
                return 'http://localhost:8000';
            // Ajoutez d'autres cas au besoin
        }
    }
}

require_once __DIR__ . '/vendor/autoload.php';
