# 02-INTERMEDIO

Ejemplos de técnicas intermedias en SQL.

## Temas cubiertos:
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- `GROUP BY` con `HAVING`
- Funciones de agregación: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- `SubQuery` en SELECT y WHERE
- `Window Functions`: `RANK()`, `ROW_NUMBER()`
- `CTE` (WITH clause)
- `CASE` statements
- `DISTINCT`

## Cómo usar:

1. **Ejecutar setup**:
   ```bash
   ./scripts/load_example.sh 02-intermedio
   ```

2. **Conectar en DBeaver** a `ejemplo_intermedio`

3. **Ejecutar queries** progresivamente

## Tablas:
- `departamentos`: id, nombre, presupuesto
- `empleados`: id, nombre, departamento_id, salario, fecha_contratacion
- `proyectos`: id, nombre, departamento_id, fecha_inicio, fecha_fin, estado
- `asignaciones`: id, empleado_id, proyecto_id, horas_asignadas
