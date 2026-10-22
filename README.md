# Al Natural — Hecho en Casa 🌿
## Sistema de Costeo de Productos Artesanales

---

## Requisitos
- **Docker** y **Docker Compose** instalados
- Puerto **3000** disponible (backend API)
- Puerto **3307** disponible (MySQL)

---

## Instalación y puesta en marcha

### 1. Levantar el backend con Docker

```bash
cd Backend_Al-Natural_Hecho_En-Casa/backend
docker-compose up --build
```

El proceso:
1. Levanta MySQL 8
2. Sincroniza el schema con Prisma
3. Ejecuta los stored procedures (seed)
4. Inicia el servidor en el puerto 3000

Espera hasta ver en los logs:
```
Iniciando servidor...
Server running on port 3000
```

### 2. Abrir el frontend

Abre el archivo `index.html` directamente en tu navegador.

> **Si el backend corre en otro host o puerto**, abre la consola del navegador (F12) y ejecuta:
> ```js
> setApiUrl('http://TU_IP:3000')
> ```

---

## Verificar que funciona

- El punto verde 🟢 en la barra superior indica que la API está conectada
- Si está rojo 🔴, el backend no responde — verifica los logs de Docker

### Test manual de la API:
```bash
curl http://localhost:3000/health
# Debe responder: {"ok":true,"message":"API funcionando correctamente"}

curl http://localhost:3000/api/ingredientes
# Debe responder: {"ok":true,"data":[...]}
```

---

## Solución de problemas

| Problema | Solución |
|----------|----------|
| Punto rojo en la app | Verifica que Docker esté corriendo: `docker-compose up` |
| Error CORS | El backend ya tiene CORS habilitado. Verifica que usas `http://` no `file://` |
| No se guardan datos | Verifica los logs del backend: `docker logs backend_api` |
| Puerto 3000 ocupado | Cambia el puerto en `docker-compose.yml` y luego: `setApiUrl('http://localhost:NUEVO_PUERTO')` |

---

## Estructura del proyecto

```
alNatural/
├── index.html          ← Frontend (abrir en navegador)
├── main.js             ← Lógica JS con llamadas a la API
├── styles.css          ← Estilos
├── logo.png
├── README.md           ← Este archivo
└── Backend_Al-Natural_Hecho_En-Casa/
    └── backend/
        ├── .env                ← Variables de entorno (creado)
        ├── docker-compose.yml  ← Docker con MySQL + Backend
        ├── Dockerfile
        ├── prisma/
        │   ├── schema.prisma   ← Modelos de base de datos
        │   ├── seed.js         ← Stored procedures + datos iniciales
        │   └── sql/            ← Stored procedures MySQL
        └── src/
            ├── app.js
            ├── server.js
            ├── routes/         ← Endpoints REST
            ├── config/
            └── middlewares/
```
