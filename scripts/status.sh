#!/bin/bash

# ═══════════════════════════════════════════════════════════
# Script: Ver estado del contenedor y bases de datos
# Uso: ./scripts/status.sh
# ═══════════════════════════════════════════════════════════

set -e

echo "📊 Estado del sistema PostgreSQL"
echo "═════════════════════════════════════════"
echo ""

# Estado del contenedor
if docker ps --filter "name=sql_practice" --filter "status=running" | grep -q "sql_practice"; then
    echo "✅ Contenedor: ACTIVO (sql_practice)"
else
    echo "❌ Contenedor: INACTIVO"
    echo ""
    exit 1
fi

echo ""
echo "📦 Bases de datos disponibles:"
echo "─────────────────────────────────────────"

docker exec sql_practice psql -U user -h localhost -w -d postgres -t -c "
SELECT datname as nombre
FROM pg_database
WHERE datname NOT IN ('postgres', 'template0', 'template1')
ORDER BY datname;
"

echo ""
echo "📄 Conexión para DBeaver:"
echo "─────────────────────────────────────────"
echo "  URL: postgresql://user:password@localhost:5433/"
echo "  Host: localhost"
echo "  Puerto: 5433"
echo "  Usuario: user"
echo "  Contraseña: password"
echo ""
