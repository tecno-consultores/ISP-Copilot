# ISP-Copilot 🛰️🤖

**ISP-Copilot** es una solución de código abierto diseñada para transformar el soporte técnico y la gestión de red en los Proveedores de Servicios de Internet (ISP). 

Este proyecto integra el monitoreo robusto de **Zabbix** y **Graylog** con la orquestación inteligente de **n8n** y agentes de **Inteligencia Artificial** para automatizar el soporte de Nivel 1 y asistir en diagnósticos avanzados de Nivel 2.

## 🚀 Características Principales

*   **Soporte Nivel 1 Automatizado:** Resolución de dudas comunes y verificación de estado de servicios sin intervención humana.
*   **Asistente NOC Inteligente:** Correlación de eventos y sugerencias de resolución de fallas basadas en datos reales.
*   **Arquitectura Modular:** Despliegue independiente de Zabbix, n8n y demas servicios mediante Docker.
*   **Privacidad y Control:** Diseñado para funcionar con modelos de IA locales para mantener los datos de los clientes seguros.

## 📂 Estructura del Proyecto

El repositorio está dividido en módulos independientes:

*   [`/zabbix`](./zabbix): Configuración de Docker para Zabbix Server, Base de Datos y Web Interface.
*   [`/n8n`](./n8n): Configuración de n8n para la orquestación de flujos de IA.
*   [`/ai`](./ai): Prompts y configuraciones del agente inteligente.
*   [`/semaphore`](./semaphore): Instalador de [Semaphore](https://github.com/semaphoreui/semaphore)
*   [`/graylog`](./graylog): Instalador de [graylog](https://github.com/Graylog2/graylog2-server)

## 🛠️ Requisitos Previos

*   Docker y Docker Compose instalado.
*   Ubuntu 24.04 o superior (Recomendado).
*   [Nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) en caso de usar ollama o hermes con GPU.

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - mira el archivo [LICENSE](LICENSE) para detalles.
