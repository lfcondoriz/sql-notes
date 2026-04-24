-- ═══════════════════════════════════════════════════════════
-- NBA Database - Consultas de Ejemplo
-- ═══════════════════════════════════════════════════════════

-- 1. Listar todos los equipos con su conferencia
SELECT nombre, ciudad, conferencia, estadio
FROM Equipo
ORDER BY nombre;

-- 2. Contar jugadores por equipo
SELECT 
    e.nombre as equipo,
    COUNT(DISTINCT jp.idJugador) as cantidad_jugadores
FROM Equipo e
LEFT JOIN JugadorParticipaCompeticion jp ON e.id = jp.idEquipo
GROUP BY e.id, e.nombre
ORDER BY cantidad_jugadores DESC;

-- 3. Jugadores con mayor puntuación en un partido
SELECT 
    p.nombre,
    p.apellido,
    jg.puntos,
    jg.asistencias,
    jg.rebotes
FROM JuegaPartido jg
JOIN Jugador j ON jg.idJugador = j.idPersona
JOIN Persona p ON j.idPersona = p.id
WHERE jg.puntos IS NOT NULL
ORDER BY jg.puntos DESC
LIMIT 10;

-- 4. Equipos que jugaron un partido específico
SELECT DISTINCT
    e.nombre,
    e.ciudad,
    e.conferencia
FROM Equipo e
JOIN Partido p ON (e.id = p.idEquipoLocal OR e.id = p.idEquipoVisitante)
LIMIT 5;

-- 5. Promedio de puntos por equipo
SELECT 
    e.nombre,
    ROUND(AVG(jg.puntos), 2) as promedio_puntos,
    COUNT(jg.idJugador) as cantidad_registros
FROM Equipo e
JOIN JugadorParticipaCompeticion jp ON e.id = jp.idEquipo
JOIN Jugador j ON jp.idJugador = j.idPersona
JOIN JuegaPartido jg ON j.idPersona = jg.idJugador
WHERE jg.puntos IS NOT NULL
GROUP BY e.id, e.nombre
ORDER BY promedio_puntos DESC;
