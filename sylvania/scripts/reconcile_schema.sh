#!/bin/bash
# reconcile_schema.sh <GOLDEN_DB> <TARGET_DB>
# Ajoute au TARGET les tables et colonnes presentes dans GOLDEN mais absentes (additif, non destructif).
G="$1"; T="$2"
Q(){ sudo mysql -N -e "$1"; }
# Tables golden absentes du target -> creation (structure seule)
for tbl in $(Q "SELECT table_name FROM information_schema.tables WHERE table_schema='$G' AND table_type='BASE TABLE' AND table_name NOT IN (SELECT table_name FROM information_schema.tables WHERE table_schema='$T')"); do
  echo "  + TABLE $tbl"
  sudo mysqldump --no-data --no-tablespaces "$G" "$tbl" | grep -ivE '^[[:space:]]*(USE|CREATE DATABASE|DROP DATABASE)' | sudo mysql "$T"
done
# Colonnes golden (tables communes) absentes du target -> ALTER ADD
Q "SELECT c.table_name,c.column_name,c.column_type,c.is_nullable,c.extra
   FROM information_schema.columns c
   WHERE c.table_schema='$G'
     AND c.table_name IN (SELECT table_name FROM information_schema.tables WHERE table_schema='$T')
     AND NOT EXISTS (SELECT 1 FROM information_schema.columns t WHERE t.table_schema='$T' AND t.table_name=c.table_name AND t.column_name=c.column_name)" \
| while IFS=$'\t' read tbl col ctype isnull extra; do
  nullsql="NULL"; [ "$isnull" = "NO" ] && nullsql="NOT NULL DEFAULT 0"
  echo "  + COLONNE $tbl.$col ($ctype)"
  sudo mysql "$T" -e "ALTER TABLE \`$tbl\` ADD COLUMN \`$col\` $ctype $nullsql $extra" 2>&1 | grep -v '^$' || true
done
