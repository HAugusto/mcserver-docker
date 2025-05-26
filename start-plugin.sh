#!/bin/sh

echo "[INFO] Aguardando o servidor iniciar completamente..."
while ! grep -q "Done (" /server/logs/latest.log 2>/dev/null; do
	sleep 1;
done

tmux send-keys -t minecraft-server "chunky center" C-m
tmux send-keys -t minecraft-server "chunky radius 2000" C-m
tmux send-keys -t minecraft-server "chunky start" C-m
