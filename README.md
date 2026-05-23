# ISP-Copilot 🛰️🤖

**ISP-Copilot** es una solución de código abierto diseñada para transformar el soporte técnico y la gestión de red en los Proveedores de Servicios de Internet (ISP). 

Este proyecto integra el monitoreo robusto de **Zabbix** con la orquestación inteligente de **n8n** y agentes de **Inteligencia Artificial** para automatizar el soporte de Nivel 1 y asistir en diagnósticos avanzados de Nivel 2 y 3.

## 🚀 Características Principales

*   **Soporte Nivel 1 Automatizado:** Resolución de dudas comunes y verificación de estado de servicios sin intervención humana.
*   **Asistente NOC Inteligente:** Correlación de eventos y sugerencias de resolución de fallas basadas en datos reales.
*   **Arquitectura Modular:** Despliegue independiente de Zabbix y n8n mediante Docker.
*   **Privacidad y Control:** Diseñado para funcionar con modelos de IA locales para mantener los datos de los clientes seguros.

## 📂 Estructura del Proyecto

El repositorio está dividido en módulos independientes:

*   [`/zabbix-stack`](./zabbix-stack): Configuración de Docker para Zabbix Server, Base de Datos y Web Interface.
*   [`/n8n-stack`](./n8n-stack): Configuración de n8n para la orquestación de flujos de IA.
*   [`/ai-core`](./ai-core): Prompts y configuraciones del agente inteligente.

## 🛠️ Requisitos Previos

*   Docker y Docker Compose instalado.
*   Ubuntu 24.04 o superior (Recomendado).

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - mira el archivo [LICENSE](LICENSE) para detalles.
