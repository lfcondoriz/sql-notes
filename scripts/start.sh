#!/bin/bash

# ═══════════════════════════════════════════════════════════
# Script: Iniciar contenedor PostgreSQL
# Uso: ./scripts/start.sh
# ═══════════════════════════════════════════════════════════

set -e

echo "🚀 Iniciando contenedor PostgreSQL..."

docker compose up -d

# Esperar a que PostgreSQL esté listo
echo "⏳ Esperando a que PostgreSQL esté listonline..."
until docker exec sql_practice pg_isready -U user > /dev/null 2>&1; do
  sleep 1
done

echo "✅ PostgreSQL está listo en localhost:5432"
echo ""
echo "Credenciales por defecto:"
echo "  Usuario: user"
echo "  Contraseña: password"
echo "  Puerto: 5432"
echo ""
echo "📝 Para cargar un ejemplo:"
echo "  ./scripts/load_example.sh 01-basico"
echo "  ./scripts/load_example.sh 02-intermedio"
echo "  ./scripts/load_example.sh 03-avanzado"
