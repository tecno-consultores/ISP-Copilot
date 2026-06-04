# 🚀 ISP-Copilot

ISP-Copilot es un ecosistema NetDevOps diseñado para automatizar y facilitar la gestión operativa de un Proveedor de Servicios de Internet (ISP). Actúa como un agente inteligente de triage, soporte y mantenimiento, integrando sistemas de monitoreo, bases de conocimiento y canales de comunicación.

## 🏗️ Arquitectura del Sistema

El proyecto está dividido en cuatro componentes operativos principales y una capa de infraestructura común:

### Componente 1: Bot de Atención al Cliente (Nivel 0)

* Interactúa con los clientes a través de WhatsApp para solicitudes de soporte técnico o temas de facturación.
* Clasifica la solicitud, precarga la información correspondiente y la entrega al módulo de IA.
* Opera estrictamente con permisos de **solo lectura** para realizar diagnósticos de cara al usuario.
* Consulta la API del sistema de facturación para comprobar el estado del contrato al momento del contacto.
* Mantiene un registro de fallas y utiliza un historial o cola para evitar diagnósticos redundantes; si varios usuarios de la misma zona reportan la misma falla, el bot diagnostica una vez y responde a los demás con esa información.
* Al finalizar, indica el resultado al usuario y, de ser necesario, notifica al NOC mediante un ticket o alerta con los pasos y resultados.
* Deja un log de todas las comunicaciones en una tabla de n8n o base de datos.

### Componente 2: Copiloto NOC (Soporte L1/L2)

* Interfaz dedicada para los técnicos del NOC a través de OpenWebUI y/u otra interfaz web.
* Cuenta con acceso a las herramientas de diagnóstico y se conecta a los equipos por SSH o peticiones API.
* Tiene la capacidad de realizar cambios en Zabbix, como cambiar el nivel de una alerta o cerrar un error.
* Deja un log estricto de los comandos ejecutados en una tabla de n8n o base de datos.

### Componente 3: Mantenimiento y Revisión Programada (Cron)

* Ejecuta respaldos diarios automatizados de los routers y equipos compatibles.
* Durante periodos donde el NOC no está disponible (ej. feriados o noches), un cron se ejecuta cada 5 minutos conectándose a los equipos por SSH/API para hacer revisiones rápidas y leer los logs de los últimos 10 minutos en Graylog.

### Componente 4: Triage Autónomo (Reactivo)

* Actúa como sustituto del personal de soporte Nivel 1, siendo independiente del componente cron.
* Zabbix o Graylog envían alertas directamente al bot, el cual se inicia para atender la falla, tomando acciones correctivas o notificando al nivel superior si es grave.
* Implementa un mecanismo **"Human-in-the-loop"**, enviando solicitudes por Telegram, Slack u otra plataforma para que el personal de guardia confirme las acciones del bot.
* Si Zabbix envía una actualización colocando el problema en estatus OK, se le notifica al técnico de inmediato.

## 🧠 Elementos Comunes e Infraestructura

* **Sistema de Tickets:** Cada interacción genera un ID de ticket único.
* **Telemetría Centralizada:** Existe un servidor Graylog donde los equipos dejan sus logs para ser consultados por el bot.
* **Agente de Terminal:** El bot cuenta con un agente disponible vía terminal de comandos (posiblemente Hermes) para las tareas más complejas.
* **Safe Mode:** Implementa el "Safe Mode" de MikroTik en las llamadas API/SSH para acciones de escritura; si el bot ejecuta un comando y pierde conexión, el router revierte el cambio automáticamente a los 10 minutos.
* **Flujos Modulares:** Las herramientas de diagnóstico están creadas en workflows separados en n8n para ser consumidas por varios flujos sin repetir estructuras.
* **Motor RAG (Generación Aumentada por Recuperación):** Integrado con la última documentación de MikroTik, Zabbix, Proxmox, libros de switching, manuales de OLT, referencia de terminal y procedimientos internos de la empresa.

## 🛠️ Herramientas de Diagnóstico Integradas

El agente tiene acceso exclusivo a las siguientes herramientas predefinidas:

* `consultar_estado_bgp`: Revisa si los peers BGP están establecidos y cuántas rutas reciben (`/routing bgp connection print detail`).
* `verificar_balanceo_pcc`: Revisa el tráfico en las interfaces WAN del ECMP/PCC para confirmar distribución equitativa (`/interface monitor-traffic [find] once`).
* `diagnosticar_recursos_router`: Revisa CPU, memoria, temperatura y voltaje (`/system resource print`, `/system health print`).
* `revisar_sesion_pppoe`: Busca la conexión, IP asignada, uptime y consumo de un usuario (`/ppp active print detail where name="usuario"`).
* `consultar_potencia_optica_ont`: Se conecta a la OLT (Huawei/ZTE) y extrae valores Rx/Tx para descartar cortes de fibra física.
* `verificar_agotamiento_cgnat`: Consulta escasez en los pools de IPs públicas.
* `liberar_sesion_pppoe`: Desconecta sesiones colgadas para forzar autenticación (`/ppp active remove [find name="usuario"]`).
* `reiniciar_puerto_poe`: Ejecuta un Power-Cycle a un puerto para reiniciar antenas o switches bloqueados (`/interface ethernet poe power-cycle [find name="puerto"]`).
* `auditar_conexiones_ecmp`: Verifica si las sesiones se están marcando y distribuyendo correctamente (`/ip firewall connection print where connection-mark="..."`).

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
