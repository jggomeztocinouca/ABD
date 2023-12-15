-- Reinicar la base de datos
DROP DATABASE IF EXISTS empresaAlimentacion;

-- Creación de la base de datos
CREATE DATABASE empresaAlimentacion;

-- Uso de la base de datos
\c empresaAlimentacion;

-- Creación de esquema
CREATE SCHEMA empresa_alimentacion;

-- Tabla Proveedores
CREATE TABLE empresa_alimentacion.proveedores (
                                                  id_proveedor SERIAL PRIMARY KEY,
                                                  nombre VARCHAR(100),
                                                  contacto VARCHAR(100)
);

-- Tabla Categorías
CREATE TABLE empresa_alimentacion.categorias (
                                                 id_categoria SERIAL PRIMARY KEY,
                                                 nombre VARCHAR(50)
);

-- Tabla Productos
CREATE TABLE empresa_alimentacion.productos (
                                                id_producto SERIAL PRIMARY KEY,
                                                nombre VARCHAR(100),
                                                precio DECIMAL,
                                                id_proveedor INT REFERENCES empresa_alimentacion.proveedores(id_proveedor),
                                                id_categoria INT REFERENCES empresa_alimentacion.categorias(id_categoria)
);

-- Tabla Empleados
CREATE TABLE empresa_alimentacion.empleados (
                                                id_empleado SERIAL PRIMARY KEY,
                                                nombre VARCHAR(100),
                                                puesto VARCHAR(100)
);

-- Tabla Clientes
CREATE TABLE empresa_alimentacion.clientes (
                                               id_cliente SERIAL PRIMARY KEY,
                                               nombre VARCHAR(100),
                                               direccion VARCHAR(200)
);

-- Tabla Pedidos
CREATE TABLE empresa_alimentacion.pedidos (
                                              id_pedido SERIAL PRIMARY KEY,
                                              fecha DATE,
                                              id_cliente INT REFERENCES empresa_alimentacion.clientes(id_cliente),
                                              id_empleado INT REFERENCES empresa_alimentacion.empleados(id_empleado)
);

-- Tabla Facturas
CREATE TABLE empresa_alimentacion.facturas (
                                               id_factura SERIAL PRIMARY KEY,
                                               id_pedido INT REFERENCES empresa_alimentacion.pedidos(id_pedido),
                                               total DECIMAL,
                                               fecha_emision DATE
);

-- Copia de seguridad (pg_dump)
-- pg_dump -h localhost -U postgres -d empresaAlimentacion -f backup.sql

-- Restaurar copia de seguridad
-- psql -h localhost -U postgres -d empresaAlimentacion -f backup.sql

-- Cuando usar VACUUM
-- VACUUM libera espacio no utilizado por la base de datos sin bloquear las operaciones de lectura o escritura.
-- Bueno para tablas con frecuentes actualizaciones/borrados.

-- Cuándo usar VACUUM FULL
-- VACUUM FULL reescribe la tabla en el disco para compactarla y ocupar menos espacio.
-- Útil para tablas que han sufrido muchas actualizaciones/borrados.

-- Cuándo usar ANALYZE
-- Actualiza las estadísticas de la base de datos, lo que ayuda al planificador de consultas a optimizar la ejecución de las mismas.
-- Mejora los tiempos de consulta en tablas que son frecuentemente consultadas.

