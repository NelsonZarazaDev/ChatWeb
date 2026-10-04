# Roadmap

## Fase 0 — Inicialización

Estado: en progreso.

- [x] Crear repositorio.
- [x] Inicializar Spring Boot.
- [x] Configurar Gradle.
- [x] Agregar dependencias base.
- [x] Diseñar modelo inicial en pgModeler.
- [x] Exportar SQL inicial.
- [ ] Cerrar revisión final del modelo SQL.
- [ ] Crear primera migración Flyway.
- [ ] Configurar PostgreSQL.
- [ ] Configurar Redis.

## Fase 1 — Backend V1

- [ ] Estructurar monolito modular.
- [ ] Implementar entidades JPA.
- [ ] Implementar repositorios.
- [ ] Configurar manejo global de errores.
- [ ] Implementar validación.
- [ ] Implementar usuarios.
- [ ] Implementar autenticación JWT.
- [ ] Configurar Spring Security.
- [ ] Implementar chat DIRECT.
- [ ] Implementar chat GROUP.
- [ ] Implementar membresías y roles.
- [ ] Implementar historial paginado.
- [ ] Implementar envío de mensajes.
- [ ] Implementar respuestas a mensajes.
- [ ] Implementar lectura de mensajes.
- [ ] Configurar WebSocket/STOMP.
- [ ] Autorizar conexiones y suscripciones WebSocket.
- [ ] Implementar presencia con Redis.
- [ ] Implementar indicador de escritura.
- [ ] Agregar pruebas unitarias.
- [ ] Agregar pruebas de integración con Testcontainers.

## Fase 2 — Frontend V1

Tecnología pendiente de definir.

- [ ] Seleccionar stack frontend.
- [ ] Login.
- [ ] Lista de conversaciones.
- [ ] Vista de chat.
- [ ] Crear conversación directa.
- [ ] Crear grupo.
- [ ] Administración de miembros.
- [ ] Mensajes en tiempo real.
- [ ] Indicador de lectura.
- [ ] Indicador de escritura.
- [ ] Presencia online/offline.
- [ ] Reconexión automática WebSocket.

## Fase 3 — Infraestructura

- [ ] Docker Compose para PostgreSQL y Redis.
- [ ] Dockerizar backend.
- [ ] Dockerizar frontend.
- [ ] Variables de entorno.
- [ ] Health checks.
- [ ] CI.
- [ ] Estrategia de despliegue.

## Fase 4 — Funcionalidades posteriores

Fuera de V1:

- [ ] Archivos adjuntos.
- [ ] Imágenes.
- [ ] Audio.
- [ ] Reacciones.
- [ ] Mensajes fijados.
- [ ] Búsqueda avanzada.
- [ ] Notificaciones push.
- [ ] Multiempresa.
- [ ] Auditoría avanzada.
- [ ] Escalamiento horizontal.
- [ ] Evaluar Kafka solo si aparecen consumidores asíncronos y eventos durables.
