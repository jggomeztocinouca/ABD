-- MEJORAS EN EL ESQUEMA:
-- Mejora 1:
-- En la tabla autores, campos como ciudad, estado y cp (código postal) pueden estar duplicados entre varios autores.
-- Sería más eficiente tener una tabla separada para direcciones y referenciarla en autores.
-- Mejora 2:
-- Similarmente a la primera mejora, en editores, ciudad, estado y pais podrían normalizarse en una tabla de direcciones.

-- Disparador de prevención de borrado para autores: No se puede borrar un autor que tenga títulos publicados.
CREATE OR REPLACE FUNCTION prevent_delete_autores() -- https://www.postgresql.org/docs/current/plpgsql-trigger.html
    RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM tituloautor WHERE au_id = OLD.au_id) THEN
        RAISE EXCEPTION 'No se puede borrar un autor con títulos publicados'; -- https://www.postgresql.org/docs/current/plpgsql-errors-and-messages.html
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql; -- https://www.postgresql.org/docs/current/sql-createtrigger.html

CREATE TRIGGER before_delete_autores -- https://www.postgresql.org/docs/current/sql-createtrigger.html
    BEFORE DELETE ON autores
    FOR EACH ROW
EXECUTE FUNCTION prevent_delete_autores();

-- Disparador para actualizar la cantidad de ventas en 'titulos'
CREATE OR REPLACE FUNCTION update_cant_ventas()
    RETURNS TRIGGER AS $$
BEGIN
    -- Calcula la cantidad total de ventas para el título específico
    UPDATE titulos
    SET cant_ventas = COALESCE(cant_ventas, 0) + NEW.cant
    WHERE titulo_id = NEW.titulo_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_insert_venta
    AFTER INSERT ON ventas
    FOR EACH ROW
EXECUTE FUNCTION update_cant_ventas();

