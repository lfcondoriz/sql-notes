-- ═══════════════════════════════════════════════════════════
-- EJERCICIOS AVANZADOS - FUNCIONES, VISTAS, TRIGGERS, ÍNDICES
-- ═══════════════════════════════════════════════════════════

-- 1. USAR FUNCIÓN: Días desde registro
SELECT nombre, 
       fecha_registro,
       dias_desde_registro(fecha_registro) as dias_registrado
FROM clientes
ORDER BY dias_registrado DESC;

-- 2. USAR FUNCIÓN: Total de facturas por cliente
SELECT c.nombre,
       total_facturas_cliente(c.id) as monto_total
FROM clientes c
ORDER BY monto_total DESC;

-- 3. USAR FUNCIÓN: Validar email
SELECT nombre, email,
       validar_email(email) as email_valido
FROM clientes;

-- 4. CONSULTAR VISTA: Resumen de clientes
SELECT * FROM v_resumen_clientes;

-- 5. CONSULTAR VISTA: Facturas pendientes
SELECT * FROM v_facturas_pendientes;

-- 6. TRANSACTION: Actualizar múltiples facturas en una transacción
BEGIN;
UPDATE facturas SET estado = 'Pagada' WHERE id = 2;
UPDATE facturas SET estado = 'Pagada' WHERE id = 5;
-- Descomenta para confirmar o usa ROLLBACK para deshacer
COMMIT;
-- ROLLBACK;

-- 7. VERIFICAR AUDITORÍA: Ver cambios registrados
SELECT * FROM auditoria_facturas
ORDER BY fecha_cambio DESC;

-- 8. EXPLAIN: Ver plan de ejecución de query
EXPLAIN ANALYZE
SELECT c.nombre, COUNT(f.id) as total_facturas, SUM(f.monto)
FROM clientes c
LEFT JOIN facturas f ON c.id = f.cliente_id
GROUP BY c.id, c.nombre;

-- 9. CREAR ÍNDICE ADICIONAL y verificar
-- CREATE INDEX idx_auditoria_factura ON auditoria_facturas(factura_id);

-- 10. WINDOW FUNCTIONS AVANZADO: Ranking de clientes por monto
SELECT c.nombre,
       total_facturas_cliente(c.id) as monto_total,
       RANK() OVER (ORDER BY total_facturas_cliente(c.id) DESC) as ranking,
       DENSE_RANK() OVER (ORDER BY total_facturas_cliente(c.id) DESC) as dense_ranking,
       ROW_NUMBER() OVER (ORDER BY total_facturas_cliente(c.id) DESC) as row_num
FROM clientes c
WHERE c.activo = true;

-- 11. Common Table Expression (CTE) avanzado
WITH pagos_recientes AS (
    SELECT cliente_id, COUNT(*) as pagos
    FROM facturas
    WHERE estado = 'Pagada' 
    AND fecha_emision >= CURRENT_DATE - INTERVAL '30 days'
    GROUP BY cliente_id
)
SELECT c.nombre, COALESCE(pr.pagos, 0) as pagos_ultimo_mes
FROM clientes c
LEFT JOIN pagos_recientes pr ON c.id = pr.cliente_id
ORDER BY pagos_ultimo_mes DESC;

-- 12. CASE anidado: Clasificar clientes
SELECT nombre,
       total_facturas_cliente(id) as monto,
       CASE 
           WHEN total_facturas_cliente(id) > 5000 THEN 'VIP'
           WHEN total_facturas_cliente(id) > 2000 THEN 'Premium'
           WHEN total_facturas_cliente(id) > 0 THEN 'Regular'
           ELSE 'Sin compras'
       END as categoria
FROM clientes
ORDER BY monto DESC;

-- 13. CASTING: Convertir tipos de datos
SELECT nombre,
       CAST(fecha_registro AS VARCHAR) as fecha_texto,
       CAST(dias_desde_registro(fecha_registro) AS VARCHAR) as dias_texto
FROM clientes;

-- 14. String functions
SELECT nombre,
       LOWER(nombre) as nombre_minuscula,
       UPPER(nombre) as nombre_mayuscula,
       LENGTH(nombre) as longitud,
       SUBSTRING(nombre, 1, 6) as primeros_6_chars
FROM clientes;

-- 15. Math functions
SELECT id,
       monto,
       ROUND(monto, 2) as monto_redondeado,
       CEIL(monto) as monto_arriba,
       FLOOR(monto) as monto_abajo
FROM facturas;
