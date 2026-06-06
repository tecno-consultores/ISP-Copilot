# Guía de Contribución para ISP-Copilot

¡Gracias por tu interés en contribuir a **ISP-Copilot**! 🚀

Este proyecto busca transformar la gestión operativa de los Proveedores de Servicios de Internet (ISP) mediante la integración de NetDevOps, automatización inteligente y agentes de IA. Al ser un ecosistema modular que incluye herramientas como **n8n**, **Zabbix**, **Graylog**, **Semaphore** y **Qdrant**, las contribuciones en cualquiera de estas áreas son enormemente valoradas.

El objetivo de este documento es facilitar el proceso de contribución, haciéndolo lo más claro y transparente posible.

## 🧠 ¿Cómo puedes contribuir?

Existen múltiples formas en las que puedes aportar al proyecto:

1. **Reportando Errores (Bugs):** Si encuentras un fallo en los flujos de n8n, configuraciones de Zabbix, o comportamientos inesperados en el bot, abre un *Issue* detallando el problema.
2. **Sugiriendo Mejoras:** ¿Tienes una idea para un nuevo script de diagnóstico (ej. una nueva consulta API a MikroTik) o un nuevo módulo? Las propuestas son bienvenidas.
3. **Aportando Código o Flujos:** Puedes enviar un *Pull Request (PR)* con nuevos *workflows* de n8n, prompts optimizados para el agente de IA, o mejoras en los instaladores (Docker Compose, Shell).
4. **Mejorando la Documentación:** Agregar ejemplos de uso, corregir errores tipográficos o expandir la base de conocimientos RAG del proyecto.

## 🛠 Entorno de Desarrollo

Para trabajar en ISP-Copilot de manera local, te recomendamos tener el siguiente entorno preparado:

* **Sistema Operativo:** Ubuntu 24.04 (recomendado) u otra distribución Linux compatible.
* **Dependencias:** Docker y Docker Compose son obligatorios, ya que toda la arquitectura está contenerizada.
* **Hardware Adicional:** Si vas a probar modelos de IA en local (Ollama/Hermes), asegúrate de contar con el *NVIDIA Container Toolkit* debidamente configurado.

### Estructura del Proyecto

Antes de modificar el código, es importante conocer la estructura de directorios:
* `/ai`: Prompts, configuraciones del agente inteligente y lógica del RAG (Qdrant).
* `/n8n`: Configuración y *workflows* exportados para la orquestación.
* `/zabbix`: Plantillas, alertas y despliegue del servidor de monitoreo.
* `/graylog`: Configuraciones para la ingesta y parseo de logs de la red.
* `/semaphore`: Instalador y configuraciones base para automatización con Ansible/Semaphore.
* `/workflows`: Herramientas de diagnóstico y flujos modulares para n8n.

## 📝 Convenciones y Buenas Prácticas

### 1. Flujos de n8n
* Intenta mantener los flujos modulares. Si una herramienta de diagnóstico puede ser reutilizada (ej. `consultar_estado_bgp` o `liberar_sesion_pppoe`), asegúrate de crearla como un sub-workflow o de manera que pueda ser consumida por otros flujos.
* Al exportar y subir un JSON de un flujo de n8n, asegúrate de **eliminar cualquier credencial, token o dato sensible** (como URLs de EvolutionAPI, contraseñas de MikroTik, etc.).

### 2. Scripts y Docker Compose
* Usa sintaxis estándar y bien comentada para los archivos YAML y Shell scripts.
* Respeta el uso de variables de entorno (archivos `.env`) para configuraciones que cambien según el despliegue.

### 3. Agentes e Interacciones de Red
* Recuerda la regla del **Safe Mode**: Toda llamada a la API de MikroTik o acceso SSH que implique *escritura/modificación* en la infraestructura debe incorporar un mecanismo de rollback o Safe Mode para evitar aislar equipos en caso de fallo.
* Mantén el enfoque de **solo lectura** para el componente del bot de atención al cliente (Nivel 0).

## 🔄 Proceso para enviar un Pull Request (PR)

1. **Haz un Fork** del repositorio en GitHub.
2. **Clona tu Fork** en tu máquina local:
