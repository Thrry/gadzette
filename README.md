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

## Déploiement côté o2switch

o2switch bloque SSH/SFTP entrant par IP. Les runners GitHub Actions n'ont pas
une IP fixe simple à autoriser, donc le déploiement doit se faire en **pull**
depuis o2switch.

Dans cPanel, utiliser **Git™ Version Control** :

```text
Clone URL: https://github.com/Thrry/gadzette.git
Repository Path: repos/gadzette
Repository Name: gadzette
```

Ensuite, dans la fiche du repo cPanel :

1. **Update from Remote**
2. **Deploy HEAD Commit**

cPanel utilise `.cpanel.yml` pour copier le thème vers :

```text
/home/joth9587/public_html/wp-content/themes/gadzette
```

En fallback terminal, le script à lancer côté serveur est :

```bash
bash /home/joth9587/repos/gadzette/bin/deploy-theme.sh
```

Il met à jour le repo depuis GitHub, sauvegarde le thème existant, puis copie
`wp-content/themes/gadzette/` vers le WordPress de production avec `rsync`.

Voir `wp-content/themes/gadzette/docs/deploy.md`.
