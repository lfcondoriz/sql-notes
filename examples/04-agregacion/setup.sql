-- 1. Crear tablas

CREATE DATABASE ejemplo_agregacion;

\c ejemplo_agregacion

CREATE TABLE Cantante (
    nro_inscripcion INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Ronda (
    numero INT PRIMARY KEY
);

CREATE TABLE Jurado (
    nombre VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Participacion (
    nro_inscripcion INT,
    numero_ronda INT,
    PRIMARY KEY (nro_inscripcion, numero_ronda),
    FOREIGN KEY (nro_inscripcion) REFERENCES Cantante(nro_inscripcion),
    FOREIGN KEY (numero_ronda) REFERENCES Ronda(numero)
);

CREATE TABLE Puntua (
    nro_inscripcion INT,
    numero_ronda INT,
    nombre_jurado VARCHAR(100),
    puntaje INT,
    PRIMARY KEY (nro_inscripcion, numero_ronda, nombre_jurado),
    FOREIGN KEY (nro_inscripcion, numero_ronda) REFERENCES Participacion(nro_inscripcion, numero_ronda),
    FOREIGN KEY (nombre_jurado) REFERENCES Jurado(nombre)
);


-- 2. Insertar datos de ejemplo

-- Cantantes
INSERT INTO Cantante VALUES (1, 'Ana');
INSERT INTO Cantante VALUES (2, 'Bruno');
INSERT INTO Cantante VALUES (3, 'Carla');


-- Rondas
INSERT INTO Ronda VALUES (1);
INSERT INTO Ronda VALUES (2);


-- Jurados
INSERT INTO Jurado VALUES ('Juez1');
INSERT INTO Jurado VALUES ('Juez2');


-- Participaciones
INSERT INTO Participacion VALUES (1, 1);
INSERT INTO Participacion VALUES (2, 1);
INSERT INTO Participacion VALUES (3, 1);

INSERT INTO Participacion VALUES (1, 2);
INSERT INTO Participacion VALUES (2, 2);


-- Puntajes
INSERT INTO Puntua VALUES (1, 1, 'Juez1', 8);
INSERT INTO Puntua VALUES (1, 1, 'Juez2', 9);

INSERT INTO Puntua VALUES (2, 1, 'Juez1', 7);
INSERT INTO Puntua VALUES (2, 1, 'Juez2', 6);

INSERT INTO Puntua VALUES (3, 1, 'Juez1', 10);
INSERT INTO Puntua VALUES (3, 1, 'Juez2', 9);

INSERT INTO Puntua VALUES (1, 2, 'Juez1', 9);
INSERT INTO Puntua VALUES (1, 2, 'Juez2', 10);

INSERT INTO Puntua VALUES (2, 2, 'Juez1', 8);
INSERT INTO Puntua VALUES (2, 2, 'Juez2', 7);

\echo '✅ Base de datos ejemplo_agregacion creada correctamente'