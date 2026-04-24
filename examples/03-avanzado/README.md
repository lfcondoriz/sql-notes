# 03-AVANZADO

Ejemplos de técnicas avanzadas en PostgreSQL.

## Temas cubiertos:
- **Funciones PL/pgSQL**: Crear funciones personalizadas
- **Vistas**: Simplificar queries complejas
- **Triggers**: Automatizar acciones en eventos DB
- **Índices**: Optimizar rendimiento
- **Transacciones**: ACID properties
- **Window Functions**: RANK(), DENSE_RANK(), ROW_NUMBER()
- **CTE recursivas y complejas**
- **EXPLAIN/ANALYZE**: Analizar rendimiento
- **Funciones de agregación avanzadas**

## Cómo usar:

1. **Ejecutar setup**:
   ```bash
   ./scripts/load_example.sh 03-avanzado
   ```

2. **Conectar en DBeaver** a `ejemplo_avanzado`

3. **Ejecutar queries** - especialmente útil ver:
   - Las vistas (v_resumen_clientes, v_facturas_pendientes)
   - Cambios en auditoria_facturas después de UPDATE
   - EXPLAIN ANALYZE para ver optimización

## Tablas:
- `clientes`: id, nombre, email, ciudad, fecha_registro, activo
- `facturas`: id, cliente_id, fecha_emision, monto, estado
- `auditoria_facturas`: id, factura_id, estado_anterior, estado_nuevo, fecha_cambio, usuario

## Funciones incluidas:
- `dias_desde_registro(fecha)`: Calcula días desde un fecha
- `total_facturas_cliente(id)`: Suma total de facturas de un cliente
- `validar_email(varchar)`: Valida formato email
