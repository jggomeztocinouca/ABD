DROP DATABASE IF EXISTS EMPRESA;
CREATE DATABASE EMPRESA;
\c EMPRESA;

-- Eliminación de roles y dependencias
-- Gerente
DO $$
    BEGIN
        IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'gerente') THEN
            REVOKE ALL PRIVILEGES ON EMPLEADOS FROM gerente;
            REVOKE ALL PRIVILEGES ON CLIENTES FROM gerente;
            REVOKE ALL PRIVILEGES ON ORDENES FROM gerente;
            REVOKE ALL PRIVILEGES ON DETALLE_ORDENES FROM gerente;
            DROP ROLE gerente;
        END IF;
    END
$$;

-- Vendedor
DO $$
    BEGIN
        IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'vendedor') THEN
            REVOKE ALL PRIVILEGES ON EMPLEADOS FROM vendedor;
            REVOKE ALL PRIVILEGES ON CLIENTES FROM vendedor;
            REVOKE ALL PRIVILEGES ON ORDENES FROM vendedor;
            REVOKE ALL PRIVILEGES ON DETALLE_ORDENES FROM vendedor;
            DROP ROLE vendedor;
        END IF;
    END
$$;

-- Analista
DO $$
    BEGIN
        IF EXISTS (SELECT FROM pg_roles WHERE rolname = 'analista') THEN
            REVOKE ALL PRIVILEGES ON PROVEEDORES FROM analista;
            REVOKE ALL PRIVILEGES ON CATEGORIAS FROM analista;
            REVOKE ALL PRIVILEGES ON PRODUCTOS FROM analista;
            DROP ROLE analista;
        END IF;
    END
$$;

-- Ejercicio A: Generación de roles y usuarios
CREATE ROLE gerente;
CREATE ROLE vendedor;
CREATE ROLE analista;

-- Asignar privilegios a los roles
GRANT SELECT ON EMPLEADOS, CLIENTES, ORDENES TO vendedor;
GRANT SELECT, INSERT, UPDATE ON EMPLEADOS, CLIENTES, ORDENES, DETALLE_ORDENES TO gerente;
GRANT SELECT ON PRODUCTOS, PROVEEDORES, CATEGORIAS TO analista;

-- Crear usuarios
DROP USER IF EXISTS usuario_gerente;
CREATE USER usuario_gerente WITH PASSWORD 'gerente123';
DROP USER IF EXISTS usuario_vendedor;
CREATE USER usuario_vendedor WITH PASSWORD 'vendedor123';
DROP USER IF EXISTS usuario_analista;
CREATE USER usuario_analista WITH PASSWORD 'analista123';

-- Asignar roles a usuarios
GRANT gerente TO usuario_gerente;
GRANT vendedor TO usuario_vendedor;
GRANT analista TO usuario_analista;

-- Ejercicio B: Creación de vistas

-- Vista 0: Información de las órdenes
DROP VIEW IF EXISTS vista_ordenes;
CREATE VIEW vista_ordenes AS
SELECT O.ORDENID, E.APELLIDO || ', ' || E.NOMBRE AS EMPLEADO, C.NOMBRECIA, O.FECHAORDEN
FROM ORDENES O
         JOIN EMPLEADOS E ON O.EMPLEADOID = E.EMPLEADOID
         JOIN CLIENTES C ON O.CLIENTEID = C.CLIENTEID;

-- Vista 1: Suma total de cada tipo de producto pedidos en todas las órdenes
DROP VIEW IF EXISTS vista_suma_productos;
CREATE VIEW vista_suma_productos AS
SELECT P.PRODUCTOID, SUM(D.CANTIDAD) AS TOTAL_PEDIDOS
FROM DETALLE_ORDENES D
         JOIN PRODUCTOS P ON D.PRODUCTOID = P.PRODUCTOID
GROUP BY P.PRODUCTOID;

-- Vista 2: Número de órdenes atendidas por cada empleado
DROP VIEW IF EXISTS vista_ordenes_empleado;
CREATE VIEW vista_ordenes_empleado AS
SELECT E.EMPLEADOID, E.APELLIDO || ', ' || E.NOMBRE AS EMPLEADO, COUNT(O.ORDENID) AS NUM_ORDENES
FROM EMPLEADOS E
         LEFT JOIN ORDENES O ON E.EMPLEADOID = O.EMPLEADOID
GROUP BY E.EMPLEADOID
ORDER BY NUM_ORDENES DESC;

-- Vista 3: Suma de dinero vendido por proveedor
DROP VIEW IF EXISTS vista_ventas_proveedor;
CREATE VIEW vista_ventas_proveedor AS
SELECT P.PROVEEDORID, PR.NOMBREPROV, SUM(P.PRECIOUNIT * D.CANTIDAD) AS TOTAL_VENTAS
FROM PRODUCTOS P
         JOIN DETALLE_ORDENES D ON P.PRODUCTOID = D.PRODUCTOID
         JOIN PROVEEDORES PR ON P.PROVEEDORID = PR.PROVEEDORID
GROUP BY P.PROVEEDORID, PR.NOMBREPROV;

-- Vista 4: Número de productos por categoría
DROP VIEW IF EXISTS vista_productos_categoria;
CREATE VIEW vista_productos_categoria AS
SELECT C.CATEGORIAID, C.NOMBRECAT, COUNT(P.PRODUCTOID) AS NUM_PRODUCTOS
FROM CATEGORIAS C
         JOIN PRODUCTOS P ON C.CATEGORIAID = P.CATEGORIAID
GROUP BY C.CATEGORIAID, C.NOMBRECAT;

-- Vista 5: Mejor cliente y cantidad de artículos comprados
DROP VIEW IF EXISTS vista_mejor_cliente;
CREATE VIEW vista_mejor_cliente AS
SELECT C.CLIENTEID, C.NOMBRECIA, SUM(D.CANTIDAD) AS TOTAL_ARTICULOS
FROM CLIENTES C
         JOIN ORDENES O ON C.CLIENTEID = O.CLIENTEID
         JOIN DETALLE_ORDENES D ON O.ORDENID = D.ORDENID
GROUP BY C.CLIENTEID, C.NOMBRECIA
ORDER BY TOTAL_ARTICULOS DESC
    LIMIT 1;

-- Vista 6: Lista de productos agrupada por categoría y proveedor
DROP VIEW IF EXISTS vista_productos_por_categoria_proveedor;
CREATE VIEW vista_productos_por_categoria_proveedor AS
SELECT C.NOMBRECAT, P.DESCRIPCION, PR.NOMBREPROV, PR.EMAILPROV
FROM PRODUCTOS P
         JOIN CATEGORIAS C ON P.CATEGORIAID = C.CATEGORIAID
         JOIN PROVEEDORES PR ON P.PROVEEDORID = PR.PROVEEDORID
ORDER BY C.NOMBRECAT, P.DESCRIPCION;

-- Ejercicio C: Definición de vistas materializadas e índices B-Tree

-- Vista materializada 1: Resumen de ventas por categoría
DROP MATERIALIZED VIEW IF EXISTS resumen_ventas_categoria;
CREATE MATERIALIZED VIEW resumen_ventas_categoria AS
SELECT C.NOMBRECAT, SUM(P.PRECIOUNIT * D.CANTIDAD) AS TOTAL_VENTAS
FROM PRODUCTOS P
         JOIN CATEGORIAS C ON P.CATEGORIAID = C.CATEGORIAID
         JOIN DETALLE_ORDENES D ON P.PRODUCTOID = D.PRODUCTOID
GROUP BY C.NOMBRECAT;

-- Justificación: Esta vista proporciona un acceso rápido al resumen de ventas por categoría.

-- Vista materializada 2: Resumen de ventas por empleado
DROP MATERIALIZED VIEW IF EXISTS resumen_ventas_empleado;
CREATE MATERIALIZED VIEW resumen_ventas_empleado AS
SELECT E.APELLIDO || ', ' || E.NOMBRE AS EMPLEADO, SUM(P.PRECIOUNIT * D.CANTIDAD) AS TOTAL_VENTAS
FROM EMPLEADOS E
         JOIN ORDENES O ON E.EMPLEADOID = O.EMPLEADOID
         JOIN DETALLE_ORDENES D ON O.ORDENID = D.ORDENID
         JOIN PRODUCTOS P ON D.PRODUCTOID = P.PRODUCTOID
GROUP BY E.APELLIDO, E.NOMBRE;

-- Justificación: Esta vista es útil para el análisis de rendimiento de los empleados en términos de ventas.

-- Índice 1: Índice en la columna FECHAORDEN de la tabla ORDENES
DROP INDEX IF EXISTS indice_fechaorden;
CREATE INDEX indice_fechaorden ON ORDENES (FECHAORDEN);

-- Justificación: Este índice mejora el rendimiento de las consultas que buscan órdenes en un rango específico de fechas.

-- Índice 2: Índice en la columna PRODUCTOID de la tabla DETALLE_ORDENES
DROP INDEX IF EXISTS indice_producto_detalle_ordenes;
CREATE INDEX indice_producto_detalle_ordenes ON DETALLE_ORDENES (PRODUCTOID);

-- Justificación: Este índice facilita y acelera las consultas que buscan información de detalle de órdenes basadas en productos específicos.



-- Jesús Gómez - 2023