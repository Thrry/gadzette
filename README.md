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

## Déploiement continu

La GitHub Action `.github/workflows/deploy-theme.yml` déploie le thème vers le
site WordPress de production à chaque push sur `master` qui touche
`wp-content/themes/gadzette/`.

Secrets GitHub requis :

```text
DEPLOY_HOST        hôte SSH du serveur
DEPLOY_PORT        port SSH, optionnel, 22 par défaut
DEPLOY_USER        utilisateur SSH
DEPLOY_PATH        chemin absolu du thème sur le serveur
                   exemple: /home/USER/public_html/wp-content/themes/gadzette
DEPLOY_SSH_KEY     clé privée SSH autorisée sur le serveur
DEPLOY_KNOWN_HOSTS optionnel, ligne known_hosts du serveur
```

Avant chaque synchronisation, l'action crée une archive de sauvegarde du thème
existant à côté du dossier déployé, puis synchronise avec `rsync --delete`.
