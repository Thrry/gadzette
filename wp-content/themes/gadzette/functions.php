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

    wp_register_script('gadzette-nav-active', '', [], wp_get_theme()->get('Version'), true);
    wp_enqueue_script('gadzette-nav-active');
    wp_add_inline_script('gadzette-nav-active', <<<'JS'
(() => {
  if (document.body.classList.contains("gadzette-article-continuation")) {
    document.querySelector(".gadzette-articles-head h2")?.replaceChildren("Articles");
    [
      ".gadzette-masthead",
      ".gadzette-edito-cover",
      ".gadzette-rubriques",
      ".gadzette-articles-more"
    ].forEach((selector) => document.querySelector(selector)?.remove());
  }

  const rubriquePaths = {
    "democratie-locale": "/category/democratie-locale/",
    "conseil-municipal": "/category/conseil-municipal/",
    "elu-es": "/category/elu-es/",
    "associations": "/category/associations/",
    "bibliotheque": "/category/bibliotheque/"
  };

  const bodyClasses = document.body.classList;
  let activeSlug = Object.keys(rubriquePaths).find((slug) => bodyClasses.contains(`category-${slug}`));

  if (!activeSlug) {
    const path = window.location.pathname.replace(/\/+$/, "/");
    activeSlug = Object.entries(rubriquePaths).find(([, rubriquePath]) => path === rubriquePath)?.[0];
  }

  if (!activeSlug) return;

  document.querySelectorAll(".gadzette-header .wp-block-navigation-item").forEach((item) => {
    const link = item.querySelector("a[href]");
    if (!link) return;
    const href = new URL(link.getAttribute("href"), window.location.origin).pathname.replace(/\/+$/, "/");
    if (href === rubriquePaths[activeSlug]) {
      item.classList.add("is-active-rubrique");
      link.setAttribute("aria-current", "page");
    }
  });
})();
JS);
});

add_filter('body_class', function (array $classes): array {
    $article_page = isset($_GET['query-8-page']) ? absint(wp_unslash($_GET['query-8-page'])) : 0;
    if ($article_page > 1) {
        $classes[] = 'gadzette-article-continuation';
    }

    if (is_single()) {
        foreach (get_the_category() as $category) {
            $classes[] = 'category-' . sanitize_html_class($category->slug);
        }
    }

    if (is_category()) {
        $category = get_queried_object();
        if ($category && !is_wp_error($category)) {
            $classes[] = 'category-' . sanitize_html_class($category->slug);
        }
    }

    return array_values(array_unique($classes));
});
