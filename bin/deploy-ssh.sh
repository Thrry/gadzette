#!/usr/bin/env bash
set -euo pipefail

REMOTE_USER="${REMOTE_USER:-joth9587}"
REMOTE_HOST="${REMOTE_HOST:-hevea.o2switch.net}"
REMOTE_PORT="${REMOTE_PORT:-22}"
REMOTE_THEME_PATH="${REMOTE_THEME_PATH:-/home/joth9587/public_html/wp-content/themes/gadzette}"
LOCAL_THEME_PATH="${LOCAL_THEME_PATH:-wp-content/themes/gadzette}"

if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Working tree has uncommitted changes. Commit before deploying." >&2
  exit 1
fi

current_branch="$(git branch --show-current)"
if [ "$current_branch" != "master" ]; then
  echo "Expected branch master, got $current_branch." >&2
  exit 1
fi

git fetch origin master
local_head="$(git rev-parse master)"
remote_head="$(git rev-parse origin/master)"

if [ "$local_head" != "$remote_head" ]; then
  echo "Local master is not equal to origin/master. Push first with: git push" >&2
  exit 1
fi

test -f "$LOCAL_THEME_PATH/style.css"
test -f "$LOCAL_THEME_PATH/theme.json"
test -f "$LOCAL_THEME_PATH/templates/home.html"

ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" \
  "mkdir -p '/home/$REMOTE_USER/theme-backups' && if [ -d '$REMOTE_THEME_PATH' ]; then tar -C \"$(dirname "$REMOTE_THEME_PATH")\" -czf \"/home/$REMOTE_USER/theme-backups/gadzette-theme-\$(date +%Y%m%d%H%M%S).tgz\" \"$(basename "$REMOTE_THEME_PATH")\"; fi && mkdir -p '$REMOTE_THEME_PATH'"

rsync -az --delete \
  -e "ssh -p $REMOTE_PORT" \
  "$LOCAL_THEME_PATH/" \
  "$REMOTE_USER@$REMOTE_HOST:$REMOTE_THEME_PATH/"

echo "Deployed $LOCAL_THEME_PATH to $REMOTE_USER@$REMOTE_HOST:$REMOTE_THEME_PATH"
