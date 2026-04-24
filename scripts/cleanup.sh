#!/bin/bash

# ═══════════════════════════════════════════════════════════
# Script: Limpiar y detener contenedor
# Uso: ./scripts/cleanup.sh
# ═══════════════════════════════════════════════════════════

set -e

echo "🧹 Limpiando..."

if docker ps -a --filter "name=sql_practice" | grep -q "sql_practice"; then
    echo "🛑 Deteniendo contenedor sql_practice..."
    docker compose down
    echo "✅ Contenedor detenido"
fi

if [ -d "data" ]; then
    echo "🗑️  Eliminando volumen de datos..."
    rm -rf data
    echo "✅ Volumen eliminado"
fi

echo ""
echo "✅ Limpieza completa"
echo ""
echo "Para volver a empezar:"
echo "  ./scripts/start.sh"
