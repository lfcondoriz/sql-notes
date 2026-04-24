# Flujo típico de trabajo

1. Levantas DB:

    ```bash
    docker compose up -d
    ```

2. Cargas script:

    ```bash
    docker exec -i postgres_dev psql -U dev -d dev_db < ejemplos/Agregación/script-agregacion.sql
    ```

3. Consultas:

    ```bash
    docker exec -it postgres_dev psql -U dev -d dev_db
    ```

4. Reset rápido:

    ```bash
    docker compose down -v
    ```


# Agregación
## ¿Qué es una agregación?

Una agregación es cuando tomás: *una relación entre entidades
y la “convertís” en algo que puede relacionarse con otra entidad.*

👉 En otras palabras: tratás una relación como si fuera una entidad

**VER IMAGEN EN EL APUNTE PAGINA 88**

# Del modelo entidad-relación (ER) a SQL
## 🔹 1. Entidades fuertes → tablas

### 🎤 Cantante

Atributos:

* nro_inscripcion (PK)
* nombre

```sql id="c1"
CREATE TABLE Cantante (
    nro_inscripcion INT PRIMARY KEY,
    nombre VARCHAR(100)
);
```

---

### 🥁 Ronda

Atributo:

* numero (PK)

```sql id="c2"
CREATE TABLE Ronda (
    numero INT PRIMARY KEY
);
```

---

### 🧑‍⚖️ Jurado

Atributo:

* nombre (PK según el diagrama)

```sql id="c3"
CREATE TABLE Jurado (
    nombre VARCHAR(100) PRIMARY KEY
);
```

---

## 🔹 2. Relación “Participa en” (Cantante ↔ Ronda)

Esto es una relación **N–N**, así que se transforma en tabla intermedia.

👉 La agregación “Participación” en SQL se representa como esta tabla.

```sql id="c4"
CREATE TABLE Participacion (
    nro_inscripcion INT,
    numero_ronda INT,

    PRIMARY KEY (nro_inscripcion, numero_ronda),

    FOREIGN KEY (nro_inscripcion) REFERENCES Cantante(nro_inscripcion),
    FOREIGN KEY (numero_ronda) REFERENCES Ronda(numero)
);
```

---

## 🔹 3. Relación “Puntúa” (Jurado → Participación)

Acá está la clave del ejercicio.

El diagrama dice:

> Jurado puntúa una **participación**

👉 Eso en SQL se traduce como que la tabla **Participacion ahora es referenciada**

---

## ✔️ Tabla de puntaje

```sql id="c5"
CREATE TABLE Puntua (
    nro_inscripcion INT,
    numero_ronda INT,
    nombre_jurado VARCHAR(100),
    puntaje INT,

    PRIMARY KEY (nro_inscripcion, numero_ronda, nombre_jurado),

    FOREIGN KEY (nro_inscripcion, numero_ronda)
        REFERENCES Participacion(nro_inscripcion, numero_ronda),

    FOREIGN KEY (nombre_jurado)
        REFERENCES Jurado(nombre)
);
```

---

## 🔴 Qué está pasando conceptualmente

### Antes (modelo ER)

* Cantante participa en Ronda → relación
* Jurado puntúa esa relación → agregación

### Después (SQL)

* “Participación” → tabla intermedia
* “Puntúa” → otra tabla que referencia esa intermedia

---

### 🔹 Interpretación simple

| Concepto ER          | SQL real               |
| -------------------- | ---------------------- |
| Agregación           | FK a tabla intermedia  |
| Participación        | tabla N–N              |
| Puntúa participación | tabla con FK compuesta |

---

## 🔑 Resumen final

Tu modelo queda como 4 tablas:

```text
Cantante(nro_inscripcion PK, nombre)

Ronda(numero PK)

Participacion(nro_inscripcion PK/FK, numero_ronda PK/FK)

Puntua(nro_inscripcion FK, numero_ronda FK, jurado FK, puntaje)
```

---

## 💡 Idea clave de examen

La agregación:

> no crea una “tabla especial nueva”

👉 solo significa:

* “una relación se vuelve referenciable por otra relación”

