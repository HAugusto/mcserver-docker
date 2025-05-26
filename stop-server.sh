#!/bin/sh

SESSION="minecraft-server"

if tmux has-session -t "$SESSION"; then
	echo "[INFO] Salvando o mundo..."
	tmux send-keys -t "$SESSION" "save-all" C-m
	sleep 2
	echo "[INFO] Parando o servidor $SESSION..."
	tmux send-keys -t "$SESSION" "stop" C-m
	sleep 5
	exit 0
else
	echo "[ERRO] Sessão $SESSION não encontrada."
	exit 1
fi
