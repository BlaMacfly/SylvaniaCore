#!/usr/bin/env bash
# Watchdog worldserver AUTO-REPARANT (v2, 2026-06-14).
#  - relance si le process est mort (comme avant) ;
#  - NOUVEAU : detecte le "hung" bind-fail (process UP mais port 8085 jamais
#    bind = "StartNetwork failed to bind socket acceptor") -> le tue et relance ;
#  - attend la liberation du port avant de relancer (evite la course TIME_WAIT).
# Pause maintenance : touch /home/ubuntu/scripts/world-watchdog.disabled
set -u
BIN=/home/ubuntu/server/bin
SESSION=world
TEE=/home/ubuntu/world.log
WLOG=/home/ubuntu/scripts/world-watchdog.log
FLAG=/home/ubuntu/scripts/world-watchdog.disabled
SINCE=/home/ubuntu/scripts/.world_notlistening_since
PORT=8085
BOOT_GRACE=150   # s : un boot normal bind en ~30s ; au-dela sans port = hung

[ -f "$FLAG" ] && exit 0

port_up() { ss -ltn 2>/dev/null | grep -q ":$PORT "; }

if pgrep -x worldserver >/dev/null 2>&1; then
    if port_up; then
        rm -f "$SINCE"           # sain : process up + port en ecoute
        exit 0
    fi
    # process up mais port absent : soit boot en cours, soit hung (bind-fail)
    now=$(date +%s)
    [ -f "$SINCE" ] || { echo "$now" > "$SINCE"; exit 0; }
    if [ $(( now - $(cat "$SINCE" 2>/dev/null || echo "$now") )) -lt "$BOOT_GRACE" ]; then
        exit 0                   # encore dans le delai de boot, on patiente
    fi
    echo "$(date '+%F %T') HUNG: worldserver UP mais port $PORT absent depuis >${BOOT_GRACE}s -> kill" >> "$WLOG"
    pkill -x worldserver
    rm -f "$SINCE"
    sleep 3
fi

# worldserver absent (ou qu'on vient de tuer) : attendre que le port soit libre, puis relancer
for i in $(seq 1 30); do port_up || break; sleep 1; done
rm -f "$SINCE"
tmux kill-session -t "$SESSION" 2>/dev/null || true
tmux new-session -d -s "$SESSION" "cd $BIN && ./worldserver 2>&1 | tee -a $TEE"
echo "$(date '+%F %T') worldserver (re)lance dans tmux ($SESSION)" >> "$WLOG"
