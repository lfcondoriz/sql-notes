# 01-BÁSICO

Ejemplos introductorios de SQL con PostgreSQL.

## Temas cubiertos:
- `CREATE TABLE`
- `INSERT INTO`
- `SELECT`, `WHERE`
- `ORDER BY`, `LIMIT`
- `COUNT()`, `SUM()`
- `JOIN` básico

## Cómo usar:

1. **Ejecutar setup** (crear DB y datos):
   ```bash
   ./scripts/load_example.sh 01-basico
   ```

2. **Conectar en DBeaver** a la base `ejemplo_basico`

3. **Ejecutar queries** desde `queries.sql` una por una

## Tablas:
- `usuarios`: id, nombre, edad, email, fecha_registro
- `productos`: id, nombre, precio, stock
- `ordenes`: id, usuario_id, producto_id, cantidad, fecha_orden
