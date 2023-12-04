-- Los siguientes índices se realizan con la intención de acelerar la búsqueda 
-- de las principales tablas, que en este caso también son las más usadas a la 
-- hora de generar informes, y dado a que estos informes se  realizan a partir 
-- de la fecha se utiliza esta columna para la creación de los índices. 

USE BD_Proyecto_Tienda;

-- DROP INDEX index_factura_compra ON FACTURA_COMPRA;

CREATE INDEX index_factura_compra
ON FACTURA_COMPRA(fac_com_fecha)
USING BTREE;

-- DROP INDEX index_factura_venta ON FACTURA_VENTA;

CREATE INDEX index_factura_venta
ON FACTURA_VENTA(fac_ven_fecha)
USING BTREE;

-- DROP INDEX index_factura_gasto ON FACTURA_GASTO;

CREATE INDEX index_factura_gasto
ON FACTURA_GASTO(fac_gas_fecha)
USING BTREE;