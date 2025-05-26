# 🛠️ Minecraft Server Dev (Spigot)

Servidor de desenvolvimento Minecraft usando **Spigot** com suporte a **plugins**, gerenciamento com **Docker**, `tmux` para controle de sessão e scripts automatizados para iniciar e parar com segurança.

---

## 🚀 Funcionalidades

- ✅ Baseado em **Spigot 1.21.4**
- 🔌 Suporte completo a plugins via volume (`./data/plugins`)
- 🧠 Gerenciamento da sessão com `tmux` para manter o servidor ativo
- 💾 Salvamento automático e parada segura via script (`stop-server.sh`)
- 🌍 Pré-carregamento de chunks com [Chunky](https://modrinth.com/plugin/chunky)
- 🔧 Totalmente configurável com `.env`

---

## 📁 Estrutura

```
.
├── Dockerfile
├── docker-compose.yml
├── start.sh                 # Inicia o servidor Spigot
├── stop-server.sh           # Salva e encerra o servidor com segurança
├── tmux.sh                  # Gerencia a sessão tmux e captura SIGTERM
├── .env                     # Variáveis de ambiente
└── data/                 <- precisa ser criado manualmente, mas pode ser gerado pelo próprio jogo
    ├── plugins/             # Plugins .jar
    ├── seu_mundo/           # Mundo principal
    ├── seu_mundo_nether/    # Nether
    ├── seu_mundo_the_end/   # The End
    ├── whitelist.json       # Registro de jogadores na whitelist
    ├── banned-ips.json      # Registro de IPs bloqueados
    ├── banned-players.json  # Registro de jogadores bloqueados
    ├── ops.json             # Registro de operadores no servidor
    └── logs/
```

---

## ⚙️ Uso

### 1. Configure `.env`

Crie um arquivo `.env` na raiz com:

```env
SERVER_EULA=                  # EULA
SERVER_VERSION=               # Versão do mundo
SERVER_LEVEL_NAME=            # Nome do mundo (default=mc_saxoworld)
SERVER_PORT=                  # Porta utilizada (default=25565)
SERVER_GAMEMODE=              # Modo de jogo (default=survival)
SERVER_DIFFICULTY=            # Dificuldade do mundo (default=normal)
SERVER_WHITELIST_ENABLE=      # Habilitar whitelist (default=false)
SERVER_TIMEZONE=              # Horário do servidor (default=America/Sao_Paulo)
SERVER_MAX_PLAYERS=           # Número máximo de jogadores (default=20)
SERVER_VIEW_DISTANCE=         # Distância máxima de render (default=10)
SERVER_SIMULATION_DISTANCE=   # Distância máxima de simulação (default=10)
SERVER_ONLINE=                # Verificação online da MOJANG (default=true)
SERVER_SPAWN_PROTECTION=      # Proteção de spawn (default=16)
```

---

### 2. Build do container

```bash
docker compose build
```

---

### 3. Inicie o servidor

```bash
docker compose up -d
```

> Caso queira fazer os passos 2 e 3 diretamente:
> ```bash
> docker compose up --build -d
> ```
---

### 4. Parar com segurança

```bash
docker compose exec spigot /stop-server.sh
```

Ou simplesmente:

```bash
docker compose stop
```

> O script `tmux.sh` escuta SIGTERM para executar parada segura automaticamente.

---

## 📦 Plugins

Adicione seus `.jar` na pasta `./data/plugins`.

Plugins testados:

- ✅ [Chunky](https://modrinth.com/plugin/chunky)
- ✅ [Dynmap](https://modrinth.com/plugin/dynmap)
- ✅ [Clumps](https://modrinth.com/plugin/clumps)
- ✅ [ImageFrame](https://modrinth.com/plugin/imageframe)

---

## 💻 Acesso ao console do servidor

```bash
docker compose exec -it minecraft-server sh
tmux attach -t minecraft-server
```

Para sair do `tmux` sem parar o servidor:

```
CTRL + B, depois D
```

---

## 🧹 Limpeza (opcional)

Para parar e remover os containers, sem apagar volumes:

```bash
docker compose down
```

---

## 📜 Licença

MIT. Livre para usar, modificar e compartilhar.

```
MIT License

Copyright (c) 2025 Higor Augusto

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.
```

---
