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
    # Usar sudo si es necesario (los permisos pertenecen a PostgreSQL dentro del contenedor)
    if rm -rf data 2>/dev/null; then
        echo "✅ Volumen eliminado"
    else
        echo "⚠️  Se necesitan permisos de administrador para limpiar completamente"
        sudo rm -rf data
        echo "✅ Volumen eliminado con sudo"
    fi
fi

echo ""
echo "✅ Limpieza completa"
echo ""
echo "Para volver a empezar:"
echo "  ./scripts/start.sh"
