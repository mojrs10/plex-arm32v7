#!/bin/bash

set -e

# Postavi korisničke podatke za Git
git config --global user.name "GitHub Actions"
git config --global user.email "actions@github.com"

echo "🔧 Postavljam prava na izvršavanje za potrebne fajlove..."

chmod 755 root/etc/s6-overlay/s6-rc.d/init-plex-gid-video/run
chmod 755 root/etc/s6-overlay/s6-rc.d/init-plex-update/run
chmod 755 root/etc/s6-overlay/s6-rc.d/init-plex-claim/run
chmod 755 root/etc/s6-overlay/s6-rc.d/init-plex-chown/run
chmod 755 root/etc/s6-overlay/s6-rc.d/svc-plex/run

git add root/etc/s6-overlay/s6-rc.d/init-plex-gid-video/run
git add root/etc/s6-overlay/s6-rc.d/init-plex-update/run
git add root/etc/s6-overlay/s6-rc.d/init-plex-claim/run
git add root/etc/s6-overlay/s6-rc.d/init-plex-chown/run
git add root/etc/s6-overlay/s6-rc.d/svc-plex/run

# Provjeri je li bilo promjena
if ! git diff-index --quiet HEAD --; then
  echo "✅ Dodani fajlovi s ispravnim pravima."
  git commit -m "Fix: Set executable permissions on Plex s6 scripts"
  echo "✅ Commit napravljen."
  git push
  echo "🚀 Pushano na GitHub!"
else
  echo "Nema promjena za commit."
fi
