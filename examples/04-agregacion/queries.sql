
-- CONSULTAS TÍPICAS DE EXAMEN

-- 1. Puntaje total por cantante
SELECT 
    c.nombre,
    SUM(pu.puntaje) AS puntaje_total
FROM Cantante c
JOIN Participacion pa ON c.nro_inscripcion = pa.nro_inscripcion
JOIN Puntua pu 
    ON pa.nro_inscripcion = pu.nro_inscripcion
    AND pa.numero_ronda = pu.numero_ronda
GROUP BY c.nombre;


-- 2. Mejor cantante (ranking)
SELECT 
    c.nombre,
    SUM(pu.puntaje) AS total
FROM Cantante c
JOIN Participacion pa ON c.nro_inscripcion = pa.nro_inscripcion
JOIN Puntua pu 
    ON pa.nro_inscripcion = pu.nro_inscripcion
    AND pa.numero_ronda = pu.numero_ronda
GROUP BY c.nombre
ORDER BY total DESC;


-- 3. Puntajes por ronda
SELECT 
    pa.numero_ronda,
    c.nombre,
    SUM(pu.puntaje) AS total
FROM Puntua pu
JOIN Participacion pa 
    ON pu.nro_inscripcion = pa.nro_inscripcion
    AND pu.numero_ronda = pa.numero_ronda
JOIN Cantante c ON c.nro_inscripcion = pa.nro_inscripcion
GROUP BY pa.numero_ronda, c.nombre;


-- 4. Qué jurado puso más puntaje total
SELECT 
    nombre_jurado,
    SUM(puntaje) AS total_dado
FROM Puntua
GROUP BY nombre_jurado
ORDER BY total_dado DESC;

