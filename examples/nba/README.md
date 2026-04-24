# NBA Database - Base de datos de la NBA

Ejemplo completo de una base de datos relacional con información de equipos, jugadores, entrenadores, partidos y eventos de la NBA.

## 📊 Tablas principales

- **Evento** - Eventos (competiciones, exhibiciones)
- **Competicion** - Competiciones específicas de la NBA
- **Exhibicion** - Juegos de exhibición
- **Equipo** - Equipos de la NBA
- **Persona** - Información de personas (jugadores y entrenadores)
- **Jugador** - Datos de jugadores
- **JugadorPosicion** - Posiciones que puede jugar cada jugador
- **Entrenador** - Datos de entrenadores
- **Partido** - Partidos jugados
- **JuegaPartido** - Estadísticas de jugadores en partidos
- **Premio** - Premios y reconocimientos
- **DrafteaJugador** - Historial de draft

## 🚀 Usar este ejemplo

```bash
./scripts/load_example.sh nba
```

Luego conecta desde **DBeaver** a la base de datos **`nba`**.

## 💡 Queries para practicar

Ver [queries.sql](queries.sql) para ejemplos de consultas.
