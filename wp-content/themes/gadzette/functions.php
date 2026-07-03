<?php

add_action('wp_enqueue_scripts', function () {
    wp_enqueue_style(
        'gadzette-tokens',
        get_template_directory_uri() . '/tokens.css',
        [],
        wp_get_theme()->get('Version')
    );

    wp_enqueue_style(
        'gadzette-theme',
        get_stylesheet_uri(),
        ['gadzette-tokens'],
        wp_get_theme()->get('Version')
    );
});
