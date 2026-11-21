#!/bin/bash
# Boucle de test du phasage d'une zone sur dc_world_test : portage, prerequis LC, simulateur, exclusion des
# PNJ qui creent un blocage nouveau, jusqu'a 0 blocage nouveau.
# Usage : boucle_zone.sh <zone> [exclus_initiaux] [quetes_sans_prerequis] [phases_non_portees]
Z=$1; EX=${2:-0}; SANSPREV=${3:-0}; SP=${4:+--sans-phases $4}
cd ~/tmp/phasage
mysql -N dc_world -e "SELECT CONCAT('UPDATE \`quest_template_addon\` SET \`PrevQuestID\`=',l.PrevQuestID,' WHERE \`ID\`=',q.ID,' AND \`PrevQuestID\`=0; -- ',REPLACE(q.LogTitle,'''',''),' <- ',REPLACE(p.LogTitle,'''','')) FROM quest_template q JOIN quest_template_addon a ON a.ID=q.ID JOIN lc_world_ref.quest_template_addon l ON l.ID=q.ID JOIN quest_template p ON p.ID=l.PrevQuestID WHERE q.QuestSortID=$Z AND a.PrevQuestID=0 AND l.PrevQuestID<>0 AND q.ID NOT IN ($SANSPREV) ORDER BY q.ID" > prereqs_$Z.sql
echo "prerequis : $(wc -l < prereqs_$Z.sql)"
for n in 1 2 3 4 5 6; do
  python3 ~/tmp/port_phasage_zone.py $Z --exclure $EX $SP > /dev/null
  for t in creature gameobject phase_area conditions creature_addon quest_template_addon; do
    mysql -e "DROP TABLE IF EXISTS dc_world_test.$t; CREATE TABLE dc_world_test.$t LIKE dc_world.$t; INSERT INTO dc_world_test.$t SELECT * FROM dc_world.$t;"
  done
  mysql dc_world_test < phasage_$Z.sql && mysql dc_world_test < prereqs_$Z.sql || exit 1
  python3 ~/tmp/verif_phasage.py dc_world $Z | tail -n +2 | sort > avant_$Z.txt
  python3 ~/tmp/verif_phasage.py dc_world_test $Z phasage_${Z}_hotfixes.sql | tail -n +2 | sort > apres_$Z.txt
  NOUV=$(comm -13 avant_$Z.txt apres_$Z.txt)
  echo "passe $n exclus=$EX nouveaux=$(echo -n "$NOUV" | grep -c .) avant=$(wc -l < avant_$Z.txt) apres=$(wc -l < apres_$Z.txt)"
  [ -z "$NOUV" ] && break
  echo "$NOUV"
  IDS=$(echo "$NOUV" | sed "s/.*\[\(.*\)\]/\1/" | tr -d " " | tr "\n" ",")
  EX=$EX,${IDS%,}
done
echo "$EX" > exclus_$Z.txt
