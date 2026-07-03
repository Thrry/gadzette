# Déployer le thème La GaDzette

Ce dossier est un block theme WordPress versionné. Il capture la V2 de la home
qui a d'abord été faite dans l'éditeur WordPress.

## Installation

1. Copier `wp-content/themes/gadzette/` dans le `wp-content/themes/` du site.
2. Dans WordPress, activer le thème **La GaDzette**.
3. Aller dans l'éditeur de site et vérifier le modèle `Accueil GaDzette`.

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
