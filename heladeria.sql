-- Creación de la base de datos para la heladería
DROP DATABASE IF EXISTS heladeria;
CREATE DATABASE heladeria;
\c heladeria;

-- Creación de roles
CREATE ROLE gerente LOGIN ENCRYPTED PASSWORD 'gerente2023%' CREATEDB;
CREATE ROLE camarero LOGIN NOCREATEDB NOCREATEROLE VALID UNTIL '2024-12-31';
CREATE ROLE limpieza NOLOGIN;

-- Creación de esquemas y tablas
CREATE SCHEMA personal AUTHORIZATION gerente;
CREATE SCHEMA inventario AUTHORIZATION gerente;

CREATE TABLE personal.empleados (
                                    id SERIAL PRIMARY KEY,
                                    nombre VARCHAR(100),
                                    puesto VARCHAR(50),
                                    fecha_contratacion DATE
);

CREATE TABLE inventario.productos (
                                      id SERIAL PRIMARY KEY,
                                      nombre VARCHAR(100),
                                      precio DECIMAL(5, 2)
);

-- Asignación de permisos a los roles
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA personal TO gerente;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA personal TO camarero;
REVOKE ALL PRIVILEGES ON SCHEMA inventario FROM PUBLIC;

-- Listado de roles y permisos
SELECT rolname FROM pg_roles;
SELECT * FROM information_schema.table_privileges WHERE grantee = 'camarero';

-- Consulta para obtener el tamaño de las tablas sin sus índices
SELECT pg_database.datname, pg_size_pretty (pg_database_size(pg_database.datname)) AS tamaño
FROM pg_database;

-- Modificación de roles
ALTER ROLE camarero VALID UNTIL '2025-01-01';

-- Listado de roles y permisos
SELECT rolname FROM pg_roles;
SELECT * FROM information_schema.table_privileges WHERE grantee = 'camarero';