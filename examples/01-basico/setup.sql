-- ═══════════════════════════════════════════════════════════
-- EJEMPLO 01: BÁSICO - CREATE, INSERT, SELECT
-- ═══════════════════════════════════════════════════════════

CREATE DATABASE ejemplo_basico;

\c ejemplo_basico

-- Crear tabla
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT,
    email VARCHAR(100) UNIQUE,
    fecha_registro DATE DEFAULT CURRENT_DATE
);

-- Insertar datos
INSERT INTO usuarios (nombre, edad, email) VALUES
    ('Juan Pérez', 25, 'juan@example.com'),
    ('María García', 30, 'maria@example.com'),
    ('Carlos López', 28, 'carlos@example.com'),
    ('Ana Martínez', 35, 'ana@example.com'),
    ('Luis Rodríguez', 22, 'luis@example.com');

-- Crear tabla de productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2),
    stock INT
);

INSERT INTO productos (nombre, precio, stock) VALUES
    ('Laptop', 1200.00, 5),
    ('Mouse', 25.00, 50),
    ('Teclado', 75.00, 30),
    ('Monitor', 300.00, 10);

-- Tabla de órdenes
CREATE TABLE ordenes (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    producto_id INT REFERENCES productos(id),
    cantidad INT,
    fecha_orden DATE DEFAULT CURRENT_DATE
);

INSERT INTO ordenes (usuario_id, producto_id, cantidad) VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 1),
    (1, 4, 1),
    (4, 2, 5);

\echo '✅ Base de datos ejemplo_basico creada correctamente'
