#!/usr/bin/env bash
#
# Publie les bases de contenu du royaume (dc_world + dc_hotfixes) comme assets
# d une Release GitHub sur BlaMacfly/SylvaniaCore.
#
# Pourquoi une Release et pas le depot : dc_world pese ~880 Mo en base (~78 Mo
# une fois dumpe et gzippe) et dc_hotfixes ~126 Mo. Git ne sait pas differencier
# une archive gzip : chaque rafraichissement alourdirait l historique de ~80 Mo
# a jamais, et GitHub refuse tout fichier de plus de 100 Mo. Les assets de
# Release, eux, vivent hors de l historique et montent a 2 Go piece.
#
# Contrairement a ~/scripts/db-backup-world.sh (sauvegarde chiffree, depot
# prive), ce script produit des dumps EN CLAIR destines a etre publics. Il ne
# touche jamais a dc_characters ni a dc_auth : ces bases contiennent des donnees
# de comptes et de personnages, et leurs schemas vierges sont deja fournis dans
# sql/base/ du depot.
#
# Prerequis : un jeton GitHub a portee fine (Contents: Read and write sur le
# seul depot SylvaniaCore) depose dans ~/.config/sylvania-github-token, en 600.
#
# Usage :
#   db-release-github.sh --dry-run     # dumpe et verifie, ne publie rien
#   db-release-github.sh               # dumpe et publie la Release
#   db-release-github.sh --tag DB-SYLVANIA-20260901
#
set -euo pipefail

REPO_SLUG="${SYLVANIA_REPO_SLUG:-BlaMacfly/SylvaniaCore}"
TOKEN_FILE="${SYLVANIA_GH_TOKEN_FILE:-$HOME/.config/sylvania-github-token}"
WORKDIR="${SYLVANIA_RELEASE_WORKDIR:-$HOME/db-release}"
MIN_FREE_MB=2048

DATE="$(date '+%Y%m%d')"
TAG="DB-SYLVANIA-${DATE}"
DRY_RUN=0

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --tag)     TAG="${2:?--tag attend une valeur}"; shift 2 ;;
    -h|--help) sed -n '2,24p' "$0"; exit 0 ;;
    *) echo "Option inconnue : $1" >&2; exit 2 ;;
  esac
done

die() { echo "ERREUR: $*" >&2; exit 1; }

# --- Verifications preliminaires ---------------------------------------------
command -v mysqldump >/dev/null || die "mysqldump introuvable"
command -v curl      >/dev/null || die "curl introuvable"
command -v gzip      >/dev/null || die "gzip introuvable"

mkdir -p "$WORKDIR"
free_mb=$(df -Pm "$WORKDIR" | awk 'NR==2 {print $4}')
[ "$free_mb" -ge "$MIN_FREE_MB" ] || die "espace disque insuffisant sur $WORKDIR : ${free_mb} Mo libres, ${MIN_FREE_MB} Mo requis"

if [ "$DRY_RUN" -eq 0 ]; then
  [ -s "$TOKEN_FILE" ] || die "jeton GitHub absent : $TOKEN_FILE (voir l en-tete de ce script)"
  perms=$(stat -c '%a' "$TOKEN_FILE")
  [ "$perms" = "600" ] || die "$TOKEN_FILE doit etre en 600 (actuellement $perms)"
fi

# --- Dumps --------------------------------------------------------------------
# Flags alignes sur ~/scripts/db-backup-world.sh, deja eprouves sur le serveur
# en production. Les tables `updates` et `updates_include` sont volontairement
# conservees : elles portent l historique deja applique, ce qui evite au core de
# rejouer les ~330 fichiers de sql/updates/world sur une base qui les contient
# deja.
declare -A DUMPS=( [world]=dc_world [hotfixes]=dc_hotfixes )
ASSETS=()

for name in world hotfixes; do
  src="${DUMPS[$name]}"
  out="${WORKDIR}/sylvania_${name}_${DATE}.sql.gz"
  echo "==> dump ${src} -> $(basename "$out")"

  # Les tables de travail laissees par d anciennes maintenances (bak_*, tmp_*)
  # ne sont pas du contenu : inutile de les publier.
  ignore=()
  while IFS= read -r t; do
    [ -n "$t" ] && ignore+=( "--ignore-table=${src}.${t}" )
  done < <(sudo mysql -N -B -e "select table_name from information_schema.tables \
             where table_schema='${src}' \
               and (table_name like 'bak\\_%' or table_name like 'tmp\\_%');" 2>/dev/null)
  [ ${#ignore[@]} -gt 0 ] && echo "    ${#ignore[@]} table(s) de travail exclue(s)"

  # Portabilite MySQL : le serveur tourne sous MariaDB 11.4, dont la collation
  # par defaut (utf8mb4_uca1400_*) n existe pas sous MySQL 8 -- un import s y
  # arreterait sur "Unknown collation". utf8mb4_unicode_ci est reconnue par les
  # deux moteurs et partage la meme semantique (UCA, insensible a la casse et
  # aux accents).
  if ! sudo mysqldump --single-transaction --quick --no-tablespaces \
         ${ignore[@]+"${ignore[@]}"} "$src" \
       | sed -E 's/utf8mb4_uca1400_[a-z_]+/utf8mb4_unicode_ci/g' \
       | gzip -c > "$out"; then
    rm -f "$out"; die "le dump de ${src} a echoue"
  fi
  [ -s "$out" ] || die "dump vide pour ${src}"
  # Un dump tronque (mysqldump interrompu) ne porte pas sa ligne de cloture.
  if ! gzip -dc "$out" | tail -5 | grep -q "Dump completed"; then
    rm -f "$out"; die "dump de ${src} tronque : ligne de cloture absente"
  fi
  if gzip -dc "$out" | grep -q "uca1400"; then
    rm -f "$out"; die "collation MariaDB residuelle dans le dump de ${src}"
  fi
  ASSETS+=("$out")
  echo "    $(du -h "$out" | cut -f1)"
done

# --- Empreintes ---------------------------------------------------------------
SUMS="${WORKDIR}/SHA256SUMS-${DATE}.txt"
( cd "$WORKDIR" && sha256sum "$(basename "${ASSETS[0]}")" "$(basename "${ASSETS[1]}")" ) > "$SUMS"
ASSETS+=("$SUMS")
cat "$SUMS"

# --- Corps de la Release ------------------------------------------------------
BODY_FILE="${WORKDIR}/body-${DATE}.md"
cat > "$BODY_FILE" <<BODYEOF
Bases de contenu du royaume **La Legion de Sylvania**, en date du ${DATE}.

Ce sont les bases \`world\` et \`hotfixes\` telles qu elles tournent en production :
la base amont DestinyCore augmentee de tous les correctifs de contenu du royaume
(campagnes, donjons, butin, localisation frFR, modules Mercenaires et Siege des
Capitales). Elles remplacent la release DB amont si vous voulez une copie
conforme du royaume plutot qu une installation DestinyCore de base.

Les bases \`auth\` et \`characters\` ne sont pas publiees : elles contiennent des
comptes et des personnages. Leurs schemas vierges sont dans \`sql/base/\` du depot.

### Import

\`\`\`bash
gunzip -c sylvania_world_${DATE}.sql.gz    | mysql -u trinity -p world
gunzip -c sylvania_hotfixes_${DATE}.sql.gz | mysql -u trinity -p hotfixes
\`\`\`

Ces dumps ne contiennent ni \`CREATE DATABASE\` ni \`USE\` : creez les bases
d abord (\`sql/create/create_mysql.sql\`) et choisissez librement leurs noms.

La table \`updates\` est incluse et deja renseignee : le worldserver n aura donc
pas a rejouer les fichiers de \`sql/updates/world\`. Laissez malgre tout
\`Updates.EnableDatabases = 31\` et \`Updates.AutoSetup = 1\` pour que les
mises a jour ulterieures s appliquent seules.

Verifiez les archives avec \`sha256sum -c SHA256SUMS-${DATE}.txt\`.
BODYEOF

if [ "$DRY_RUN" -eq 1 ]; then
  echo
  echo "--- MODE --dry-run : rien n a ete publie ---"
  echo "Assets prets dans ${WORKDIR} :"
  printf '  %s\n' "${ASSETS[@]}"
  echo "Tag qui serait cree : ${TAG}"
  exit 0
fi

# --- Publication --------------------------------------------------------------
TOKEN="$(cat "$TOKEN_FILE")"
API="https://api.github.com/repos/${REPO_SLUG}"
UPLOAD="https://uploads.github.com/repos/${REPO_SLUG}"
auth=(-H "Authorization: Bearer ${TOKEN}" -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28")

existing=$(curl -sf "${auth[@]}" "${API}/releases/tags/${TAG}" | sed -n 's/.*"id": \([0-9]*\).*/\1/p' | head -1 || true)
[ -n "$existing" ] && die "la release ${TAG} existe deja (id ${existing}) : supprimez-la ou passez --tag"

echo "==> creation de la release ${TAG}"
payload=$(python3 - "$TAG" "$BODY_FILE" <<'PYEOF'
import json, sys, io
tag = sys.argv[1]
body = io.open(sys.argv[2], encoding="utf-8").read()
print(json.dumps({"tag_name": tag, "name": "Bases Sylvania " + tag.split("-")[-1],
                  "body": body, "draft": True, "prerelease": False}))
PYEOF
)
release_id=$(curl -sf "${auth[@]}" -X POST "${API}/releases" -d "$payload" \
             | sed -n 's/.*"id": \([0-9]*\).*/\1/p' | head -1)
[ -n "$release_id" ] || die "creation de la release impossible"

for a in "${ASSETS[@]}"; do
  echo "==> envoi de $(basename "$a")"
  curl -sf "${auth[@]}" -H "Content-Type: application/octet-stream" \
       --data-binary @"$a" \
       "${UPLOAD}/releases/${release_id}/assets?name=$(basename "$a")" >/dev/null \
    || die "envoi de $(basename "$a") echoue"
done

echo
echo "Release ${TAG} creee en BROUILLON : https://github.com/${REPO_SLUG}/releases"
echo "Relisez-la puis publiez-la depuis l interface GitHub."
