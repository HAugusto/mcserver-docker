#!/bin/sh

if [ "$SERVER_EULA" = "true" ]; then
	echo "[INFO] Aceitando EULA..."
	echo "eula=true" > /server/eula.txt
else
	echo "[ERROR] Você deve aceitaro EULA para inciar o servidor (SERVER_EULA=true)"
	exit 1
fi

if [ ! -f /server/server.properties ]; then
    	echo "[INFO] Gerando server.properties inicial (aguarde o boot inicial do servidor)..."
	java -Xms1G -Xmx1G -jar spigot-${SERVER_VERSION}.jar nogui & PID=$!
	sleep 10
	kill $PID
fi

if [ -f /server/server.properties ]; then
	echo "[INFO] Atualizando server.properties com base nas variáveis .env..."
	sed -i "s/^level-name=.*/level-name=${SERVER_LEVEL_NAME:-mc_saxoworld}/" /server/server.properties
    	sed -i "s/^server-port=.*/server-port=${SERVER_PORT:-25565}/" /server/server.properties
	sed -i "s/^gamemode=.*/gamemode=${SERVER_GAMEMODE:-survival}/" /server/server.properties
	sed -i "s/^difficulty=.*/difficulty=${SERVER_DIFFICULTY:-normal}/" /server/server.properties
	sed -i "s/^white-list=.*/white-list=${SERVER_WHITELIST_ENABLE:-false}/" /server/server.properties
    	sed -i "s/^max-players=.*/max-players=${SERVER_MAX_PLAYERS:-20}/" /server/server.properties
    	sed -i "s/^view-distance=.*/view-distance=${SERVER_VIEW_DISTANCE:-10}/" /server/server.properties
	sed -i "s/^simulation-distance=.*/simulation-distance=${SERVER_SIMULATION_DISTANCE:-10}/" /server/server.properties
    	sed -i "s/^online-mode=.*/online-mode=${SERVER_ONLINE:-true}/" /server/server.properties
	sed -i "s/^spawn-protection=.*/spawn-protection=${SERVER_SPAWN_PROTECTION:16}/" /server/server.properties
else
	echo "[ERROR] Não foi possível localizar o server.properties"
	exit 1
fi

# Inicia o servidor
echo "[INFO] Iniciando o servidor Minecraft..."
exec java -Xms8G -Xmx8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled \
	-XX:MaxGCPauseMillis=50 -XX:+UnlockExperimentalVMOptions \
	-XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
	-XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
	-XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 \
	-XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 \
	-XX:G1MixedGCLiveThresholdPercent=90 -XX:+PerfDisableSharedMem \
	-XX:+UseStringDeduplication -Dusing.aikars.flags=https://mcflags.emc.gs \
	-Daikars.new.flags=true -jar spigot-${SERVER_VERSION}.jar nogui

