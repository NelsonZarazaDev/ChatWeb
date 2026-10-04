# API REST y WebSocket

Este documento describe el contrato propuesto para la V1. Los endpoints y destinos todavía no están implementados.

## 1. Criterio de separación

### REST

Usar para:

- Autenticación.
- Gestión de usuarios.
- Crear chats.
- Consultar chats.
- Administrar miembros.
- Consultar historial.
- Consultas paginadas.

### WebSocket / STOMP

Usar para eventos en tiempo real:

- Mensaje creado.
- Mensaje editado.
- Mensaje eliminado.
- Mensaje leído.
- Usuario escribiendo.
- Presencia.

## 2. REST propuesto

Base:

```text
/api/v1
```

### Autenticación

```text
POST /api/v1/auth/login
POST /api/v1/auth/refresh
```

### Usuarios

```text
GET  /api/v1/users
GET  /api/v1/users/{userId}
```

### Chats

```text
POST /api/v1/chats
GET  /api/v1/chats
GET  /api/v1/chats/{chatId}
POST /api/v1/chats/{chatId}/members
DELETE /api/v1/chats/{chatId}/members/{userId}
PATCH /api/v1/chats/{chatId}
```

### Mensajes

```text
GET /api/v1/chats/{chatId}/messages
```

Se recomienda paginación por cursor para el historial en lugar de offset cuando el volumen crezca.

Ejemplo:

```text
GET /api/v1/chats/{chatId}/messages?before={messageId}&limit=50
```

## 3. Conexión WebSocket

Endpoint propuesto:

```text
/ws
```

La autenticación utilizará JWT asociado a la sesión STOMP.

El servidor debe validar también la autorización por chat; poseer un JWT válido no es suficiente para publicar o suscribirse a cualquier conversación.

## 4. Eventos

### Enviar mensaje

Destino propuesto:

```text
/app/chats/{chatId}/messages
```

Payload:

```json
{
  "text": "Hola equipo",
  "replyToMessageId": null
}
```

### Mensaje creado

Evento:

```json
{
  "type": "MESSAGE_CREATED",
  "data": {
    "id": "uuid",
    "chatId": "uuid",
    "senderId": "uuid",
    "text": "Hola equipo",
    "replyToMessageId": null,
    "createdAt": "2026-10-04T14:00:00-05:00"
  }
}
```

### Mensaje leído

```json
{
  "type": "MESSAGE_READ",
  "data": {
    "messageId": "uuid",
    "userId": "uuid",
    "readAt": "2026-10-04T14:01:00-05:00"
  }
}
```

### Typing

```json
{
  "type": "TYPING",
  "data": {
    "chatId": "uuid",
    "userId": "uuid",
    "typing": true
  }
}
```

Typing es un evento efímero y no debe persistirse en PostgreSQL.

## 5. Flujo para abrir un chat

```text
1. Frontend consulta el historial por REST.
2. Frontend ya mantiene una conexión WebSocket global.
3. El usuario visualiza los mensajes recibidos por REST.
4. Los mensajes nuevos llegan por WebSocket.
5. El frontend marca lecturas.
6. El servidor persiste la lectura y emite el evento correspondiente.
```

## 6. Reglas de seguridad

Antes de procesar una operación de chat, el backend debe verificar:

- JWT válido.
- Usuario activo.
- Chat existente.
- Usuario miembro del chat.
- Membresía no eliminada.
- Permisos de rol cuando la operación sea administrativa.
- El mensaje respondido, si existe, pertenece al mismo chat.

## 7. Errores

REST debe usar códigos HTTP coherentes.

Ejemplos:

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
409 Conflict
422 Unprocessable Content
```

Los errores WebSocket deberían utilizar un formato uniforme, por ejemplo:

```json
{
  "type": "ERROR",
  "code": "CHAT_ACCESS_DENIED",
  "message": "El usuario no pertenece al chat."
}
```
