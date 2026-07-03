# La GaDzette

Ce dépôt contient le thème WordPress versionné du site **La GaDzette**.

Le thème actif à déployer est dans :

```text
wp-content/themes/gadzette/
```

## Structure

```text
wp-content/themes/gadzette/
  style.css
  theme.json
  templates/
    home.html
    index.html
  parts/
    header.html
    footer.html
    post-meta.html
  assets/images/
    gadzette-logo.png
    jocelyne-etiquette-homepage-1000-q65.webp
  docs/
    deploy.md
```

## Règle de travail

Les changements de design doivent être faits dans ce thème, puis déployés sur
WordPress. Si une modification est faite directement dans l'éditeur WordPress,
il faut ensuite la reporter ici, sinon Git et WordPress divergent.

Voir aussi `wp-content/themes/gadzette/docs/deploy.md`.
