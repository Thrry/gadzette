# Déployer le thème La GaDzette

Ce dossier est un block theme WordPress versionné. Il capture la V2 de la home
qui a d'abord été faite dans l'éditeur WordPress.

## Installation

1. Copier `wp-content/themes/gadzette/` dans le `wp-content/themes/` du site.
2. Dans WordPress, activer le thème **La GaDzette**.
3. Aller dans l'éditeur de site et vérifier le modèle `Accueil GaDzette`.

## Déploiement côté o2switch

o2switch bloque SSH/SFTP entrant par IP. Les runners GitHub Actions standard
n'ont pas une IP fixe simple à autoriser. Le bon modèle est donc : le serveur
o2switch tire depuis GitHub.

## Déploiement SSH depuis le Mac

Si l'IP du Mac est autorisée dans cPanel > Autorisation SSH, le plus simple est :

```bash
git push
bin/deploy-ssh.sh
```

Le script vérifie que `master` local correspond à `origin/master`, sauvegarde
le thème distant dans `/home/joth9587/theme-backups`, puis synchronise :

```text
wp-content/themes/gadzette/
```

vers :

```text
/home/joth9587/public_html/wp-content/themes/gadzette
```

Variables possibles :

```bash
REMOTE_HOST=hevea.o2switch.net
REMOTE_USER=joth9587
REMOTE_PORT=22
REMOTE_THEME_PATH=/home/joth9587/public_html/wp-content/themes/gadzette
```

### Mise en place avec cPanel Git Version Control

Dans cPanel > **Git™ Version Control** :

```text
Clone URL: https://github.com/Thrry/gadzette.git
Repository Path: repos/gadzette
Repository Name: gadzette
```

Après création du repo cPanel :

1. Cliquer **Update from Remote** pour récupérer `master`.
2. Cliquer **Deploy HEAD Commit**.

cPanel exécutera `.cpanel.yml`, qui copie :

```text
/home/joth9587/repos/gadzette/wp-content/themes/gadzette
```

vers :

```text
/home/joth9587/public_html/wp-content/themes/gadzette
```

### Fallback terminal

Dans le terminal cPanel :

```bash
mkdir -p ~/repos
cd ~/repos
git clone https://github.com/Thrry/gadzette.git
bash ~/repos/gadzette/bin/deploy-theme.sh
```

Le script utilise ces chemins par défaut :

```text
REPO_DIR      = ~/repos/gadzette
THEME_SOURCE = ~/repos/gadzette/wp-content/themes/gadzette
THEME_TARGET = ~/public_html/wp-content/themes/gadzette
BACKUP_DIR   = ~/theme-backups
```

Si WordPress n'est pas dans `~/public_html`, lancer le script avec un chemin
explicite :

```bash
THEME_TARGET=/home/joth9587/CHEMIN/wp-content/themes/gadzette \
  bash ~/repos/gadzette/bin/deploy-theme.sh
```

### Cron optionnel

Pour un pull automatique régulier depuis cPanel Cron :

```bash
*/5 * * * * /usr/bin/bash /home/joth9587/repos/gadzette/bin/deploy-theme.sh >/home/joth9587/deploy-gadzette.log 2>&1
```

Le cron peut aussi être remplacé par un lancement manuel après chaque push.

## Point important

WordPress peut stocker les modèles modifiés dans la base. Si le modèle `home`
a déjà été personnalisé depuis l'éditeur, cette version en base peut prendre le
dessus sur `templates/home.html`.

Pour revenir à la version Git :

1. Ouvrir l'éditeur de site.
2. Sélectionner le modèle de home.
3. Utiliser l'action de réinitialisation du modèle, si WordPress l'affiche.
4. Modifier ensuite les fichiers du thème puis redéployer.

## Limite actuelle

Le bloc Query Loop de l'édito cible la catégorie WordPress `13`, qui est la
catégorie édito du site actuel. Si cette catégorie change d'ID sur une autre
installation, il faudra ajuster `templates/home.html`.
