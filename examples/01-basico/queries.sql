-- ═══════════════════════════════════════════════════════════
-- EJERCICIOS BÁSICOS - SELECT, WHERE, ORDER BY
-- ═══════════════════════════════════════════════════════════
-- Ejecuta estos queries uno por uno en DBeaver
-- Cambia primero a: SELECT * FROM pg_database WHERE datname = 'ejemplo_basico';

-- 1. Seleccionar todos los usuarios
SELECT * FROM usuarios;

-- 2. Seleccionar solo nombre y email
SELECT nombre, email FROM usuarios;

-- 3. Filtrar usuarios mayores de 25 años
SELECT * FROM usuarios WHERE edad > 25;

-- 4. Seleccionar usuarios y ordenar por edad
SELECT nombre, edad FROM usuarios ORDER BY edad DESC;

-- 5. Contar usuarios
SELECT COUNT(*) as total_usuarios FROM usuarios;

-- 6. Ver productos con stock bajo (menos de 20)
SELECT nombre, precio, stock FROM productos WHERE stock < 20;

-- 7. Calcular precio total de ordenes
SELECT o.id, u.nombre, p.nombre, o.cantidad, (p.precio * o.cantidad) as total
FROM ordenes o
JOIN usuarios u ON o.usuario_id = u.id
JOIN productos p ON o.producto_id = p.id;

-- 8. Encontrar el usuario más comprador
SELECT u.nombre, COUNT(*) as total_compras
FROM ordenes o
JOIN usuarios u ON o.usuario_id = u.id
GROUP BY u.id, u.nombre
ORDER BY total_compras DESC;

-- 9. Actualizar edad de un usuario
UPDATE usuarios SET edad = 26 WHERE nombre = 'Juan Pérez';

-- 10. Eliminar orden (comentada por seguridad)
-- DELETE FROM ordenes WHERE id = 1;
