# SQL Notes - Aprende PostgreSQL con Ejemplos Prácticos

Repositorio para aprender SQL con PostgreSQL usando **Docker Compose** y **DBeaver**.

## 📁 Estructura

```
sql-notes/
├── docker-compose.yml              ← Un solo contenedor PostgreSQL
├── examples/
│   ├── 01-basico/
│   │   ├── setup.sql               (crea DB + tablas + datos)
│   │   ├── queries.sql             (ejercicios prácticos)
│   │   └── README.md
│   ├── 02-intermedio/
│   │   ├── setup.sql
│   │   ├── queries.sql
│   │   └── README.md
│   └── 03-avanzado/
│       ├── setup.sql
│       ├── queries.sql
│       └── README.md
├── scripts/
│   ├── start.sh                    (✅ inicia contenedor - una sola vez)
│   ├── load_example.sh             (carga ejemplo específico)
│   ├── status.sh                   (ver bases de datos disponibles)
│   └── cleanup.sh                  (detiene todo y limpia)
└── data/                           (volumen PostgreSQL - se genera automático)
```

## 🎯 Ventajas de esta estructura

✅ **Un solo contenedor** - levanta una vez, reutiliza siempre  
✅ **Base de datos por ejemplo** - cada uno aislado  
✅ **Sin conflictos** - tablas no se pisan entre sí  
✅ **DBeaver conectado una vez** - cambias de DB desde la UI  
✅ **Fácil de escalar** - agregar ejemplos es trivial  

## 🚀 Quick Start

### Paso 1: Hacer scripts ejecutables

```bash
chmod +x scripts/*.sh
```

### Paso 2: Levantar PostgreSQL (primera vez solamente)

```bash
./scripts/start.sh
```

⏳ Espera a que diga `✅ PostgreSQL está listo`

### Paso 3: Cargar un ejemplo

```bash
./scripts/load_example.sh 01-basico
```

Salida esperada:
```
📦 Cargando ejemplo: 01-basico
✅ Ejemplo cargado correctamente
🔗 Conéctate desde DBeaver a:
  Database: ejemplo_basico
```

### Paso 4: Conectar desde DBeaver

1. **Archivo → New Database Connection → PostgreSQL**
2. Rellena los datos:
   | Campo | Valor |
   |----------|--------|
   | **Host** | localhost |
   | **Port** | 5433 |
   | **Database** | ejemplo_basico |
   | **Username** | user |
   | **Password** | password |
3. **Test Connection** → ✅ OK
4. **Finish**

### Paso 5: Ejecutar queries

1. Abre el archivo `examples/01-basico/queries.sql`
2. Copia cada query en DBeaver
3. Ejecuta (Ctrl+Enter)
4. Ve los resultados

## 📚 Ejemplos Disponibles

### 01-BÁSICO (`examples/01-basico/`)

**Temas:**
- `CREATE TABLE`, `INSERT`, `SELECT`
- `WHERE`, `ORDER BY`, `LIMIT`
- Funciones: `COUNT()`, `SUM()`, `MAX()`, `MIN()`
- `INNER JOIN` básico

**Tablas:**
- `usuarios` - (id, nombre, edad, email, fecha_registro)
- `productos` - (id, nombre, precio, stock)
- `ordenes` - (id, usuario_id, producto_id, cantidad, fecha_orden)

---

### 02-INTERMEDIO (`examples/02-intermedio/`)

**Temas:**
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- `GROUP BY` con `HAVING`
- Funciones de agregación: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- `SubQuery` en SELECT y WHERE
- **Window Functions**: `RANK()`, `ROW_NUMBER()`, `DENSE_RANK()`
- **CTE (WITH clause)**
- `CASE` statements
- `DISTINCT`

**Tablas:**
- `departamentos` - (id, nombre, presupuesto)
- `empleados` - (id, nombre, departamento_id, salario, fecha_contratacion)
- `proyectos` - (id, nombre, departamento_id, fecha_inicio, fecha_fin, estado)
- `asignaciones` - (id, empleado_id, proyecto_id, horas_asignadas)

---

### 03-AVANZADO (`examples/03-avanzado/`)

**Temas:**
- **Funciones PL/pgSQL** personalizadas
- **Vistas** (Views) para simplificar queries
- **Triggers** (automatización de eventos)
- **Índices** para optimizar rendimiento
- **Transacciones** (ACID)
- **EXPLAIN/ANALYZE** para ver ejecución
- Funciones de string y math

**Tablas:**
- `clientes` - (id, nombre, email, ciudad, fecha_registro, activo)
- `facturas` - (id, cliente_id, fecha_emision, monto, estado)
- `auditoria_facturas` - (id, factura_id, estado_anterior, estado_nuevo, fecha_cambio, usuario)

**Funciones incluidas:**
- `dias_desde_registro(fecha)` - Calcula días desde una fecha
- `total_facturas_cliente(id)` - Suma facturas por cliente
- `validar_email(varchar)` - Valida formato email

---

## 🔄 Flujo de Trabajo Típico

### Sesión 1: Aprender Básico

```bash
# Terminal
chmod +x scripts/*.sh
./scripts/start.sh                    # ⏳ Espera a listo
./scripts/load_example.sh 01-basico   # 📦 Carga datos

# DBeaver
# Opens → Conecta a localhost:5433
# → Abre ejemplo_basico
# → Ejecuta queries de ejemplos/01-basico/queries.sql
```

### Sesión 2: Pasar al Intermedio

```bash
# Terminal (PostgreSQL sigue corriendo, no reinicies)
./scripts/load_example.sh 02-intermedio  # 📦 Nueva DB

# DBeaver
# → Selecciona Database → ejemplo_intermedio
# → Ejecuta queries de ejemplos/02-intermedio/queries.sql
```

### Sesión 3: Explorar Avanzado

```bash
# Terminal
./scripts/load_example.sh 03-avanzado  # 📦 Nueva DB

# DBeaver
# → Database → ejemplo_avanzado
# → Experimenta con funciones, vistas, triggers
```

### Limpiar (cuando termines todo)

```bash
./scripts/cleanup.sh                  # 🧹 Elimina todo
```

---

## 🔧 Comandos útiles

### Ver estado
```bash
./scripts/status.sh
```

Muestra:
- Estado del contenedor
- Bases de datos disponibles
- Credenciales para conectar

### Verificar logs
```bash
docker logs sql_practice
```

### Conectarse directamente a PostgreSQL (sin DBeaver)
```bash
docker exec -it sql_practice psql -U user -d base_datos -p 5432
```

```bash
docker exec -it sql_practice psql -U user -d ejemplo_basico -p 5432
```

Dentro del contenedor:
```sql
\l                          -- Listar bases de datos
\c ejemplo_basico           -- Conectar a una BD
\dt                         -- Listar tablas
SELECT * FROM usuarios;     -- Ejecutar query
\q                          -- Salir
```

---

## 📖 Recomendaciones de Aprendizaje

1. **Comienza con 01-basico**
   - Entiende SELECT, WHERE, ORDER BY
   - Practica INSERT y UPDATE
   - Aprende JOINs simples

2. **Sigue con 02-intermedio**
   - Domina GROUP BY y agregaciones
   - Experimenta con JOINs múltiples
   - Aprende Window Functions

3. **Termina con 03-avanzado**
   - Crea tus propias funciones
   - Entiende optimización con índices
   - Usa triggers para automatizar

4. **Proyecto final**
   - Crea tu propia base de datos
   - Agrégala al repositorio
   - Juega combinando conceptos

---

## 🛠️ Troubleshooting

### ❌ `docker: command not found`
- Instala Docker: https://docs.docker.com/install/

### ❌ `Error: Permission denied while trying to connect to Docker daemon`
```bash
sudo usermod -aG docker $USER
# Luego cierra sesión y vuelve a abrir terminal
```

### ❌ Port 5432 already in use
```bash
# Cambiar puerto en docker-compose.yml
# Línea: ports: - "5433:5432" (en lugar de 5432:5432)
./scripts/start.sh
```

### ❌ `archivo setup.sql no existe`
Verifica que estés en el directorio correcto:
```bash
pwd  # Debe ser /home/lu/Escritorio/sql-notes
ls -la scripts/
```

---

## 📚 Recursos adicionales

- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [SQL Tutorial](https://www.w3schools.com/sql/)
- [Window Functions](https://www.postgresql.org/docs/current/functions-window.html)
- [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html)

---

## 💡 Tips

- **Aprende con pequeños pasos** - no intentes todo de una vez
- **Experimenta** - modifica queries, crea tablas nuevas
- **Lee los errores** - PostgreSQL da buenos mensajes de error
- **Usa EXPLAIN** - en 03-avanzado verás cómo optimizar

---

¡Felicidades! Tienes todo listo para aprender SQL correctamente. 🎉
