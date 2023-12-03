-- El dueño de una clínica de fisioterapia quiere que los datos de su empresa sean gestionados
-- y organizados de la manera más eficiente posible.

-- Instrucciones de borrado de tablas para su nueva construcción
DROP TABLE IF EXISTS fisioterapeuta;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS cita;

-- Fisioterapeuta
CREATE TABLE fisioterapeuta
(
    id_fisio int,
    apellidos varchar(50),
    nombre varchar(30)
);

ALTER TABLE fisioterapeuta
    ADD CONSTRAINT PK_fisioterapeuta PRIMARY KEY(id_fisio);

-- Paciente
CREATE TABLE paciente
(
    id_paciente int,
    apellidos varchar(50),
    nombre varchar(30),
    peso float,
    altura_cm int,
    fecha_nacimiento date
);

ALTER TABLE paciente
    ADD CONSTRAINT PK_paciente PRIMARY KEY(id_paciente);

-- Asociación Fisioterapeuta-Paciente: Cita
CREATE TABLE cita
(
    id_fisio int,
    id_paciente int,
    fecha timestamp,
    numero_consulta int
);

ALTER TABLE cita
    ADD CONSTRAINT PK_cita PRIMARY KEY(id_fisio,id_paciente);
ALTER TABLE cita
    ADD CONSTRAINT FK_fisio FOREIGN KEY(id_fisio) REFERENCES fisioterapeuta(id_fisio);
ALTER TABLE cita
    ADD CONSTRAINT FK_paciente FOREIGN KEY(id_paciente) REFERENCES paciente(id_paciente);