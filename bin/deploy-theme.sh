#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/repos/gadzette}"
THEME_SOURCE="${THEME_SOURCE:-$REPO_DIR/wp-content/themes/gadzette}"
THEME_TARGET="${THEME_TARGET:-$HOME/public_html/wp-content/themes/gadzette}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/theme-backups}"

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "Missing git repository: $REPO_DIR" >&2
  exit 1
fi

cd "$REPO_DIR"
git fetch origin master
git reset --hard origin/master

test -f "$THEME_SOURCE/style.css"
test -f "$THEME_SOURCE/theme.json"
test -f "$THEME_SOURCE/templates/home.html"

mkdir -p "$BACKUP_DIR"
if [ -d "$THEME_TARGET" ]; then
  tar -C "$(dirname "$THEME_TARGET")" \
    -czf "$BACKUP_DIR/gadzette-theme-$(date +%Y%m%d%H%M%S).tgz" \
    "$(basename "$THEME_TARGET")"
fi

mkdir -p "$THEME_TARGET"
rsync -az --delete "$THEME_SOURCE/" "$THEME_TARGET/"

echo "Deployed $THEME_SOURCE to $THEME_TARGET"
