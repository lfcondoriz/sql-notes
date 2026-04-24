-- ═══════════════════════════════════════════════════════════
-- EJEMPLO 02: INTERMEDIO - JOINS, GROUP BY, SUBCONSULTAS
-- ═══════════════════════════════════════════════════════════

CREATE DATABASE ejemplo_intermedio;

\c ejemplo_intermedio

-- Tabla: Departamentos
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(15, 2)
);

INSERT INTO departamentos (nombre, presupuesto) VALUES
    ('Ventas', 50000),
    ('Tecnología', 80000),
    ('Recursos Humanos', 30000),
    ('Marketing', 40000);

-- Tabla: Empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    departamento_id INT REFERENCES departamentos(id),
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

INSERT INTO empleados (nombre, departamento_id, salario, fecha_contratacion) VALUES
    ('Juan Silva', 2, 4000, '2022-01-15'),
    ('María Rodríguez', 1, 3500, '2021-05-20'),
    ('Carlos Gómez', 2, 4500, '2023-03-10'),
    ('Ana Torres', 3, 3200, '2022-08-01'),
    ('Luis Martín', 1, 3800, '2023-01-05'),
    ('Elena García', 4, 3300, '2021-11-12'),
    ('Roberto Santos', 2, 4200, '2022-06-18');

-- Tabla: Proyectos
CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    departamento_id INT REFERENCES departamentos(id),
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(20)
);

INSERT INTO proyectos (nombre, departamento_id, fecha_inicio, fecha_fin, estado) VALUES
    ('Rediseño Web', 2, '2023-01-01', '2023-06-30', 'Completado'),
    ('Campaña Verano 2023', 4, '2023-04-01', '2023-08-31', 'En progreso'),
    ('Sistema CRM', 2, '2023-03-15', '2024-01-31', 'En progreso'),
    ('Recursos para Ventas', 1, '2023-02-01', '2023-03-31', 'Completado');

-- Tabla: Asignaciones (empleado -> proyecto)
CREATE TABLE asignaciones (
    id SERIAL PRIMARY KEY,
    empleado_id INT REFERENCES empleados(id),
    proyecto_id INT REFERENCES proyectos(id),
    horas_asignadas INT
);

INSERT INTO asignaciones (empleado_id, proyecto_id, horas_asignadas) VALUES
    (1, 1, 160),
    (1, 3, 120),
    (3, 1, 140),
    (3, 3, 200),
    (2, 4, 80),
    (5, 4, 100),
    (6, 2, 120),
    (7, 1, 90);

\echo '✅ Base de datos ejemplo_intermedio creada correctamente'
