#!/bin/bash

# ═══════════════════════════════════════════════════════════
# Script: Eliminar una base de datos específica
# Uso: ./scripts/drop_db.sh <nombre_base>
# Ejemplo: ./scripts/drop_db.sh ejemplo_nba
# ═══════════════════════════════════════════════════════════

set -e

if [ -z "$1" ]; then
    echo "❌ Error: Debes especificar el nombre de la base de datos"
    echo "Uso: ./scripts/drop_db.sh <nombre_base>"
    exit 1
fi

DB_NAME=$1

# Verificar que el contenedor está corriendo
if ! docker ps --filter "name=sql_practice" --filter "status=running" | grep -q "sql_practice"; then
    echo "❌ Error: Contenedor 'sql_practice' no está corriendo"
    echo "Inicia primero con: ./scripts/start.sh"
    exit 1
fi

echo "🗑️ Eliminando la base de datos: $DB_NAME"

# Terminar conexiones activas a la base
docker exec -i sql_practice psql -U user -d postgres -c "
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = '$DB_NAME'
  AND pid <> pg_backend_pid();
"

# Eliminar la base de datos
docker exec -i sql_practice psql -U user -d postgres -c "DROP DATABASE IF EXISTS $DB_NAME;"

echo "✅ Base de datos '$DB_NAME' eliminada correctamente"