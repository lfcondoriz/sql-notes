#!/bin/bash

# ═══════════════════════════════════════════════════════════
# Script: Cargar ejemplo específico
# Uso: ./scripts/load_example.sh <nombre_ejemplo>
# Ejemplo: ./scripts/load_example.sh 01-basico
# ═══════════════════════════════════════════════════════════

set -e

if [ -z "$1" ]; then
    echo "❌ Error: Debes especificar un ejemplo"
    echo ""
    echo "Uso: ./scripts/load_example.sh <nombre_ejemplo>"
    echo ""
    echo "Ejemplos disponibles:"
    echo "  - 01-basico"
    echo "  - 02-intermedio"
    echo "  - 03-avanzado"
    exit 1
fi

EJEMPLO=$1
SETUP_FILE="examples/$EJEMPLO/setup.sql"

# Validar que existe el archivo
if [ ! -f "$SETUP_FILE" ]; then
    echo "❌ Error: No existe el archivo $SETUP_FILE"
    exit 1
fi

# Verificar que el contenedor está corriendo
if ! docker ps --filter "name=sql_practice" --filter "status=running" | grep -q "sql_practice"; then
    echo "❌ Error: Contenedor 'sql_practice' no está corriendo"
    echo "Inicia primero con: ./scripts/start.sh"
    exit 1
fi

echo "📦 Cargando ejemplo: $EJEMPLO"
echo "📄 Ejecutando: $SETUP_FILE"

# Ejecutar el setup.sql en el contenedor
docker exec -i sql_practice psql -U user -h localhost -w -d postgres < "$SETUP_FILE"

# Extraer nombre de la DB del archivo setup
DB_NAME=$(grep "CREATE DATABASE" "$SETUP_FILE" | sed 's/.*CREATE DATABASE //' | sed 's/;.*//' | xargs)

echo ""
echo "✅ Ejemplo cargado correctamente"
echo ""
echo "🔗 Conéctate desde DBeaver a:"
echo "  👤 Usuario: user"
echo "  🔐 Contraseña: password"
echo "  🖥️  Host: localhost"
echo "  🔌 Puerto: 5433"
echo "  📊 Database: $DB_NAME"
echo ""
echo "📝 Archivos del ejemplo:"
echo "  - examples/$EJEMPLO/setup.sql (ya ejecutado)"
echo "  - examples/$EJEMPLO/queries.sql (ejecuta en DBeaver)"
echo "  - examples/$EJEMPLO/README.md (instrucciones)"
