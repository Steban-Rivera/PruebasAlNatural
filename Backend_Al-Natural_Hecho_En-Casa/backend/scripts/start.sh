#!/bin/sh

echo "═══════════════════════════════════════════"
echo " Al Natural — Iniciando backend..."
echo "═══════════════════════════════════════════"

echo "Esperando MySQL..."
sleep 15

echo "Generando Prisma Client..."
npx prisma generate

echo "Sincronizando schema con la base de datos..."
npx prisma db push --accept-data-loss

echo "Ejecutando seed (stored procedures + datos iniciales)..."
node prisma/seed.js

echo "Iniciando servidor..."
node src/server.js
