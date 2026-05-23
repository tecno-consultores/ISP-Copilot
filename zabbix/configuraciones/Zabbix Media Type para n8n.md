# Zabbix Media Type: n8n Webhook Integration

Este archivo contiene la especificación de parámetros y el script en JavaScript necesario para configurar el Media Type nativo en Zabbix. Esta configuración empaqueta las macros de las alertas como un objeto JSON estructurado y seguro, eliminando los fallos de escape de caracteres y enviando los datos directamente al Webhook de n8n.

## 📋 Información General

* **Nombre:** n8n
* **Tipo:** Webhook

## ⚙️ Tabla de Parámetros (Macros de Zabbix)

Configura estos parámetros exactamente en la tabla del Media Type dentro de Zabbix:

| Parámetro | Valor | Descripción |
| :--- | :--- | :--- |
| `URL` | *[Tu URL de n8n en producción]* | URL completa del nodo Webhook de producción en n8n. |
| `event_id` | `{EVENT.ID}` | Identificador único del evento en Zabbix. |
| `event_name` | `{EVENT.NAME}` | Nombre o descripción de la alerta disparada. |
| `event_severity` | `{EVENT.SEVERITY}` | Severidad asignada a la alerta (ej. Warning, Average, High). |
| `host_name` | `{HOST.NAME}` | Nombre de host del equipo en Zabbix (ej. Core-MikroTik-RB4011). |
| `host_ip` | `{HOST.IP}` | Dirección IP principal del dispositivo monitoreado. |
| `trigger_description` | `{TRIGGER.DESCRIPTION}` | Comentarios o descripción técnica agregada al Trigger. |
| `item_last_value` | `{ITEM.LASTVALUE}` | Último valor recolectado por el ítem (ej. estado de interfaz Up/Down o potencia óptica). |
| `inventory_vendor` | `{INVENTORY.VENDOR}` | Proveedor del equipo registrado en el inventario de Zabbix (ej. MikroTik, Huawei). |

---

## 📜 Script JavaScript de Integración

Copia y pega el siguiente código en el campo **Script** del Media Type en Zabbix. Este motor se encarga de aislar la URL, construir el payload limpio en JSON de forma nativa y realizar la petición HTTP POST de manera asíncrona.

```javascript
try {
    // 1. Parsear los parámetros enviados por Zabbix
    var params = JSON.parse(value),
        req = new HttpRequest(),
        response;

    // 2. Extraer y validar la URL de forma segura
    if (!params.URL) {
        throw 'El parámetro "URL" no está definido en la lista de variables.';
    }
    var webhook_url = params.URL.trim();

    req.addHeader('Content-Type: application/json');
    
    // 3. Remover la variable URL del payload para no enviarla a n8n
    delete params.URL;

    // 4. Ejecutar el POST
    Zabbix.log(4, '[n8n Webhook] Enviando datos a: ' + webhook_url);
    response = req.post(webhook_url, JSON.stringify(params));

    // 5. Verificar el estado de la respuesta
    if (req.getStatus() !== 200) {
        throw 'Código de respuesta HTTP del servidor: ' + req.getStatus();
    }

    return 'OK';
}
catch (error) {
    Zabbix.log(3, '[n8n Webhook] Error crítico: ' + error);
    throw 'N8N Webhook failed: ' + error;
}
```

## Message template

* message type: problem
* Subject: Zabbix Alert - PROBLEM: {EVENT.NAME}
* message: 

event_id: {EVENT.ID}
event_name: {EVENT.NAME}
event_severity: {EVENT.SEVERITY}
host_name: {HOST.NAME}
host_ip: {HOST.IP}
item_name: {ITEM.NAME}
item_last_value: {ITEM.LASTVALUE}
event_status: {EVENT.STATUS}









