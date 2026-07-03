<?php

add_action('wp_enqueue_scripts', function () {
    wp_enqueue_style(
        'gadzette-theme',
        get_stylesheet_uri(),
        [],
        wp_get_theme()->get('Version')
    );
});
