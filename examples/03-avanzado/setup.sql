-- ═══════════════════════════════════════════════════════════
-- EJEMPLO 03: AVANZADO - FUNCIONES, VISTAS, ÍNDICES, TRIGGERS
-- ═══════════════════════════════════════════════════════════

CREATE DATABASE ejemplo_avanzado;

\c ejemplo_avanzado

-- Tabla: Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    ciudad VARCHAR(50),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT true
);

INSERT INTO clientes (nombre, email, ciudad) VALUES
    ('Cliente A', 'a@example.com', 'Madrid'),
    ('Cliente B', 'b@example.com', 'Barcelona'),
    ('Cliente C', 'c@example.com', 'Valencia'),
    ('Cliente D', 'd@example.com', 'Sevilla');

-- Tabla: Facturas
CREATE TABLE facturas (
    id SERIAL PRIMARY KEY,
    cliente_id INT REFERENCES clientes(id),
    fecha_emision DATE DEFAULT CURRENT_DATE,
    monto DECIMAL(12, 2),
    estado VARCHAR(20) DEFAULT 'Pendiente'
);

INSERT INTO facturas (cliente_id, monto, estado) VALUES
    (1, 1500.00, 'Pagada'),
    (1, 2000.00, 'Pendiente'),
    (2, 800.00, 'Pagada'),
    (3, 1200.00, 'Cancelada'),
    (4, 3000.00, 'Pendiente');

-- Tabla: Auditoría (para triggers)
CREATE TABLE auditoria_facturas (
    id SERIAL PRIMARY KEY,
    factura_id INT,
    estado_anterior VARCHAR(20),
    estado_nuevo VARCHAR(20),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario VARCHAR(50)
);

-- ═══════════════════════════════════════════════════════════
-- FUNCIÓN 1: Calcular edad de cliente (ejemplo básico)
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION dias_desde_registro(fecha DATE)
RETURNS INT AS $$
BEGIN
    RETURN EXTRACT(DAY FROM CURRENT_DATE - fecha);
END;
$$ LANGUAGE plpgsql;

-- ═══════════════════════════════════════════════════════════
-- FUNCIÓN 2: Obtener total de facturas por cliente
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION total_facturas_cliente(p_cliente_id INT)
RETURNS DECIMAL AS $$
DECLARE
    v_total DECIMAL;
BEGIN
    SELECT SUM(monto) INTO v_total
    FROM facturas
    WHERE cliente_id = p_cliente_id;
    
    RETURN COALESCE(v_total, 0);
END;
$$ LANGUAGE plpgsql;

-- ═══════════════════════════════════════════════════════════
-- FUNCIÓN 3: Validar email
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION validar_email(p_email VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN p_email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';
END;
$$ LANGUAGE plpgsql;

-- ═══════════════════════════════════════════════════════════
-- VISTA 1: Resumen de clientes
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE VIEW v_resumen_clientes AS
SELECT 
    c.id,
    c.nombre,
    c.ciudad,
    COUNT(f.id) as total_facturas,
    COALESCE(SUM(f.monto), 0) as monto_total,
    dias_desde_registro(c.fecha_registro) as dias_registrado
FROM clientes c
LEFT JOIN facturas f ON c.id = f.cliente_id
WHERE c.activo = true
GROUP BY c.id, c.nombre, c.ciudad, c.fecha_registro;

-- ═══════════════════════════════════════════════════════════
-- VISTA 2: Facturas pendientes por cliente
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE VIEW v_facturas_pendientes AS
SELECT 
    c.nombre as cliente,
    f.id as factura_id,
    f.monto,
    f.fecha_emision,
    (CURRENT_DATE - f.fecha_emision) as dias_pendiente
FROM facturas f
JOIN clientes c ON f.cliente_id = c.id
WHERE f.estado = 'Pendiente'
ORDER BY dias_pendiente DESC;

-- ═══════════════════════════════════════════════════════════
-- TRIGGER: Registrar cambios en facturas
-- ═══════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION log_cambio_factura()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.estado <> OLD.estado THEN
        INSERT INTO auditoria_facturas (
            factura_id, 
            estado_anterior, 
            estado_nuevo, 
            usuario
        ) VALUES (
            NEW.id,
            OLD.estado,
            NEW.estado,
            USER
        );
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditoria_facturas
AFTER UPDATE ON facturas
FOR EACH ROW
EXECUTE FUNCTION log_cambio_factura();

-- ═══════════════════════════════════════════════════════════
-- ÍNDICES para mejorar rendimiento
-- ═══════════════════════════════════════════════════════════
CREATE INDEX idx_facturas_cliente ON facturas(cliente_id);
CREATE INDEX idx_facturas_estado ON facturas(estado);
CREATE INDEX idx_clientes_ciudad ON clientes(ciudad);

-- ═══════════════════════════════════════════════════════════
-- ESTADÍSTICAS
-- ═══════════════════════════════════════════════════════════
ANALYZE;

\echo '✅ Base de datos ejemplo_avanzado creada correctamente'
