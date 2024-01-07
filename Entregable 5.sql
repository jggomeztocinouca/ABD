-- 1. Descripción de la base de datos:
-- Base de datos diseñada para gestionar las operaciones de una biblioteca.

-- 2. Motivación:
-- El propósito de este proyecto es automatizar la gestión de una biblioteca,
-- facilitando el seguimiento de los préstamos, la disponibilidad de libros y la administración de usuarios.
-- Busca mejorar la experiencia del usuario y la eficiencia administrativa, permitiendo una gestión más eficaz de los recursos
-- y una mejor experiencia para los usuarios de la biblioteca.


-- 3.1. Creación de la base de datos
DROP DATABASE IF EXISTS Biblioteca;
CREATE DATABASE Biblioteca;

-- 3.1.1. Uso de la base de datos creada
\c Biblioteca;

-- 3.2. Creación de las tablas necesarias
-- Tabla Autores
DROP TABLE IF EXISTS Autores CASCADE;
CREATE TABLE Autores (
                         id SERIAL PRIMARY KEY,
                         nombre VARCHAR(100),
                         nacionalidad VARCHAR(50)
);

-- Tabla Libros
DROP TABLE IF EXISTS Libros CASCADE;
CREATE TABLE Libros (
                        id SERIAL PRIMARY KEY,
                        titulo VARCHAR(100),
                        autor_id INT,
                        FOREIGN KEY (autor_id) REFERENCES Autores (id)
);

-- Tabla Usuarios
DROP TABLE IF EXISTS Usuarios CASCADE;
CREATE TABLE Usuarios (
                      id SERIAL PRIMARY KEY,
                      nombre VARCHAR(100),
                      email VARCHAR(50) UNIQUE
);

-- Tabla Prestamos
DROP TABLE IF EXISTS Prestamos CASCADE;
CREATE TABLE Prestamos (
                       id SERIAL PRIMARY KEY,
                       libro_id INT,
                       usuario_id INT,
                       fecha_prestamo DATE,
                       fecha_devolucion DATE,
                       FOREIGN KEY (libro_id) REFERENCES Libros (id),
                       FOREIGN KEY (usuario_id) REFERENCES Usuarios (id)
);

-- 3.3. Creación de índices
-- Índices para la tabla Autores
CREATE INDEX idx_autores_nombre ON Autores(nombre); -- Es frecuente buscar autores por nombre

-- Índices para la tabla Libros
CREATE INDEX idx_libros_titulo ON Libros(titulo); -- Es frecuente buscar libros por título
CREATE INDEX idx_libros_autor_id ON Libros(autor_id); -- Es frecuente buscar libros por autor

-- Índices para la tabla Usuarios
CREATE INDEX idx_usuarios_email ON Usuarios(email); -- Es frecuente identificar usuarios por el email, debido a que es un identificador único

-- Índices para la tabla Prestamos
CREATE INDEX idx_prestamos_libro_id ON Prestamos(libro_id); -- Indexación sobre claves foráneas (JOINS y búsquedas cruzadas más eficientes)
CREATE INDEX idx_prestamos_usuario_id ON Prestamos(usuario_id); -- Indexación sobre claves foráneas (JOINS y búsquedas cruzadas más eficientes)


-- ROLES Y USUARIOS
-- Creación de roles de grupo
CREATE ROLE db_access; -- Permiso de acceso a la base de datos
CREATE ROLE db_edit; -- Permiso de edición de la base de datos
CREATE ROLE db_maintenance; -- Permiso de mantenimiento de la base de datos
CREATE ROLE db_read; -- Permiso de lectura de la base de datos

-- Asignación de permisos a los roles
GRANT CONNECT ON DATABASE Biblioteca TO db_access;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO db_edit;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO db_read;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Libros TO db_maintenance;

-- Creación de usuarios y asignación a roles
CREATE USER Principal WITH PASSWORD 'principal' IN ROLE db_access, db_edit;
CREATE USER Colaborador WITH PASSWORD 'colaborador' IN ROLE db_access, db_edit;
CREATE USER Eventual WITH PASSWORD 'eventual' IN ROLE db_access, db_read;
CREATE USER Junior WITH PASSWORD 'junior' IN ROLE db_access, db_maintenance;
CREATE USER Externo WITH PASSWORD 'externo' IN ROLE db_access, db_read;

-- VISTAS
-- Vista de libros disponibles (para facilitar la consulta rápida de disponibilidad)
CREATE VIEW LibrosDisponibles AS
SELECT titulo FROM Libros
                       LEFT JOIN Prestamos ON Libros.id = Prestamos.libro_id
WHERE fecha_devolucion IS NOT NULL OR fecha_prestamo IS NULL;

-- Vista materializada de conteo de libros por autor (útil para estadísticas y gestión de inventario)
CREATE MATERIALIZED VIEW ConteoLibrosPorAutor AS
SELECT Autores.nombre, COUNT(Libros.id) as conteo
FROM Autores
         LEFT JOIN Libros ON Autores.id = Libros.autor_id
GROUP BY Autores.nombre;

-- Vista de usuarios activos (importante para el seguimiento de usuarios con préstamos activos)
CREATE VIEW UsuariosActivos AS
SELECT Usuarios.nombre, COUNT(Prestamos.id) as prestamos_activos
FROM Usuarios
         LEFT JOIN Prestamos ON Usuarios.id = Prestamos.usuario_id
WHERE Prestamos.fecha_devolucion IS NULL
GROUP BY Usuarios.nombre;

-- DISPARADORES
-- Disparador para verificar la disponibilidad del libro antes de un préstamo
CREATE FUNCTION verificar_disponibilidad() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Prestamos WHERE libro_id = NEW.libro_id AND fecha_devolucion IS NULL) THEN
        RAISE EXCEPTION 'El libro no está disponible para préstamo.';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verificar_disponibilidad
    BEFORE INSERT ON Prestamos
    FOR EACH ROW EXECUTE PROCEDURE verificar_disponibilidad();

-- Disparador para actualizar el conteo de libros por autor tras cambios en la tabla Libros
CREATE FUNCTION actualizar_conteo() RETURNS TRIGGER AS $$
BEGIN
    REFRESH MATERIALIZED VIEW ConteoLibrosPorAutor;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_conteo
    AFTER INSERT OR DELETE ON Libros
FOR EACH ROW EXECUTE PROCEDURE actualizar_conteo();

-- Jesús Gómez - 2024