-- ═══════════════════════════════════════════════════════════
-- EJERCICIOS INTERMEDIOS - JOINS, GROUP BY, AGREGACIONES
-- ═══════════════════════════════════════════════════════════

-- 1. INNER JOIN: empleados con su departamento
SELECT e.nombre, d.nombre as departamento, e.salario
FROM empleados e
INNER JOIN departamentos d ON e.departamento_id = d.id
ORDER BY d.nombre;

-- 2. LEFT JOIN: todos los departamentos con empleados (si tienen)
SELECT d.nombre, COUNT(e.id) as total_empleados
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id
GROUP BY d.id, d.nombre;

-- 3. GROUP BY con aggregación: salario promedio por departamento
SELECT d.nombre, 
       COUNT(e.id) as empleados,
       AVG(e.salario) as salario_promedio,
       MAX(e.salario) as salario_maximo,
       MIN(e.salario) as salario_minimo
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id
GROUP BY d.id, d.nombre
ORDER BY salario_promedio DESC;

-- 4. MULTIPLE JOIN: empleados, sus departamentos y proyectos asignados
SELECT e.nombre, 
       d.nombre as departamento, 
       p.nombre as proyecto,
       a.horas_asignadas
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.id
JOIN asignaciones a ON e.id = a.empleado_id
JOIN proyectos p ON a.proyecto_id = p.id
ORDER BY e.nombre, p.nombre;

-- 5. SubQuery: empleados que ganan más que el salario promedio
SELECT nombre, salario
FROM empleados
WHERE salario > (SELECT AVG(salario) FROM empleados)
ORDER BY salario DESC;

-- 6. GROUP BY + HAVING: departamentos con presupuesto mayor a gasto en salarios
SELECT d.nombre, 
       d.presupuesto,
       SUM(e.salario) as gasto_salarios,
       (d.presupuesto - SUM(e.salario)) as disponible
FROM departamentos d
LEFT JOIN empleados e ON d.id = e.departamento_id
GROUP BY d.id, d.nombre, d.presupuesto
HAVING SUM(e.salario) > 0
ORDER BY disponible DESC;

-- 7. Window Function: ranking de salarios por departamento
SELECT e.nombre,
       d.nombre as departamento,
       e.salario,
       RANK() OVER (PARTITION BY d.nombre ORDER BY e.salario DESC) as ranking
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.id;

-- 8. CTE (Common Table Expression): empleados con antigüedad
WITH antiguedad AS (
    SELECT id, nombre, 
           EXTRACT(YEAR FROM AGE(fecha_contratacion)) as años_antiguedad
    FROM empleados
)
SELECT * FROM antiguedad WHERE años_antiguedad >= 2;

-- 9. Distinct: proyectos por departamento
SELECT DISTINCT d.nombre, p.nombre
FROM proyectos p
JOIN departamentos d ON p.departamento_id = d.id
ORDER BY d.nombre, p.nombre;

-- 10. CASE: categorizar empleados por rango salarial
SELECT nombre, 
       salario,
       CASE 
           WHEN salario >= 4500 THEN 'Senior'
           WHEN salario >= 4000 THEN 'Mid-level'
           WHEN salario >= 3500 THEN 'Junior'
           ELSE 'Pasante'
       END as categoria
FROM empleados
ORDER BY salario DESC;
