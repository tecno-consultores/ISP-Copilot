# ISP-Copilot 🛰️🤖

## N8N

Para ejecutar N8N en AMD64/ARM64 (con Postgres y Redis):

```bash
docker compose -f docker-compose.yml --env-file env.example --profile n8n --profile n8n-worker --profile n8n-runner up -d
```

Otros perfiles que puede correr:

* [N8N](https://github.com/n8n-io/n8n) en AMD64/ARM64 (--profile n8n)
    + N8N-worker en AMD64/ARM64 (--profile n8n-worker)
    + N8N-runner (code sandbox) en AMD64/ARM64 (--profile n8n-runner)
* [Qdrant](https://github.com/qdrant/qdrant) en AMD64/ARM64 (--profile qdrant)
* [OpenwebUI](https://github.com/open-webui/open-webui) en AMD64/ARM64 (--profile openwebui)
* [Ollama](https://github.com/ollama/ollama) en Nvidia (--profile ollama-gpu)
    + Ollama en AMD64/ARM64 or AMD GPU (--profile ollama-cpu)
* [NGINX proxy manager](https://github.com/NginxProxyManager/nginx-proxy-manager) en AMD64/ARM64 (--profile proxy)
* [Searxng](https://github.com/searxng/searxng) en AMD64/ARM64 (--profile searxng)
* [EvolutionAPI](https://doc.evolution-api.com/v1/en/get-started/introduction) en AMD64/ARM64 (--profile evolutionapi)

| Nombre | Puerto | Ejemplo |
| -------- | ------- | ------- |
| N8N | 5678 | http://127.0.0.1:5678 |
| Qdrant | 6333 | http://127.0.0.1:6333/dashboard |
| OpenwebUI | 8383 | http://127.0.0.1:8383 |
| NGINX proxy manager | 81 | http://127.0.0.1:81 |
| Searxng | 8181 | http://127.0.0.1:8181 |
| EvolutionAPI | 9191 | http://127.0.0.1:9191/manager |
| Redis Insight | 8001 | http://127.0.0.1:8001 |

Repositorio oficial: https://github.com/n8n-io/n8n
