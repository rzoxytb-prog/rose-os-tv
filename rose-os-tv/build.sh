#!/usr/bin/env bash
# Rosé OS — construit les paquets pour chaque plateforme.
# Usage : ./build.sh [android|webos|tizen|web|all]
set -e
cd "$(dirname "$0")"
TARGET="${1:-all}"
rm -rf build && mkdir -p build dist

stage() { # $1 = plateforme (webos|tizen)
  mkdir -p "build/$1"
  cp -r web/. "build/$1/"
  cp -r "$1"/. "build/$1/"
}

do_android() {
  if [ -x ./gradlew ]; then ./gradlew assembleDebug; else gradle assembleDebug; fi
  cp app/build/outputs/apk/debug/app-debug.apk dist/RoseOS-androidtv.apk
}
do_webos() {
  stage webos
  if command -v ares-package >/dev/null; then
    ares-package build/webos -o dist
  else
    echo "ares-package absent (npm i -g @webos-tools/cli) : dossier prêt dans build/webos"
  fi
}
do_tizen() {
  stage tizen
  (cd build/tizen && zip -qr ../../dist/RoseOS-tizen-unsigned.wgt .)
  echo "Tizen : le .wgt doit être signé avec ton certificat Samsung (voir docs/INSTALL.md)"
}
do_web() {
  mkdir -p dist/web && cp -r web/. dist/web/
}

case "$TARGET" in
  android) do_android ;;
  webos)   do_webos ;;
  tizen)   do_tizen ;;
  web)     do_web ;;
  all)     do_web; do_webos; do_tizen; do_android ;;
  *) echo "Cible inconnue : $TARGET"; exit 1 ;;
esac
echo "Terminé -> dist/"
