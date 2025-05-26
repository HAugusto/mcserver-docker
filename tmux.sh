#!/bin/sh

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

SESSION="minecraft-server"

if [ "$1" ]; then
	exec "$@"
fi

stop_server(){
	echo "[INFO] Parando servidor com segurança..."
	/stop-server.sh
	exit 0
}

trap stop_server SIGTERM

if ! tmux has-session -t "$SESSION" 2>/dev/null; then
	echo "Criando sessão $SESSION..."
	tmux new-session -d -s "$SESSION" "export LANG=${LANG}; export LC_ALL=${LC_ALL}; /start-server.sh"
else
	echo "[ERRO] Sessão já existente..."
	exit -1;
fi

(
	/start-plugin.sh
) &

while tmux has-session -t "$SESSION" 2>/dev/null; do
	sleep 1
done
