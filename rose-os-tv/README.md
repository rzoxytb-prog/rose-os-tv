# Rosé OS — interface TV multi-plateformes

Une seule interface (`web/`), empaquetée pour :

| Dossier | Plateforme | Résultat |
|---|---|---|
| `app/` | **Android TV / Google TV** (Hitachi, Sony, Philips, TCL…) | `RoseOS-androidtv.apk` |
| `webos/` | LG webOS | `.ipk` |
| `tizen/` | Samsung Tizen | `.wgt` (à signer) |
| `web/` | N'importe quel navigateur | page statique |

`web/platform.js` fait le lien avec chaque système (ouvrir Netflix/YouTube/… , touche Retour, bouton « Revenir à l'OS d'origine »).

## Obtenir les paquets sans rien installer
1. Crée un dépôt sur github.com et envoie tout ce dossier (y compris `.github`).
2. Onglet **Actions** > **Build** > **Run workflow**.
3. Télécharge les artefacts : APK Android TV, IPK webOS, WGT Tizen.

## En local
```
./build.sh android   # nécessite Gradle + Android SDK
./build.sh webos     # nécessite npm i -g @webos-tools/cli
./build.sh tizen
./build.sh all
```
Installation sur la TV : voir `docs/INSTALL.md`.

## Modifier l'interface
Tout se passe dans `web/index.html`. Les noms de paquets Android des applis sont dans
`app/src/main/java/com/rose/tvos/MainActivity.java` (`openLink`), ceux de webOS/Tizen dans `web/platform.js`.
`tools/gen_icons.py` régénère les icônes.
