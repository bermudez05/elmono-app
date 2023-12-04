-- Realizamos actualizaciones y borrados en la base de datos creada para el proyecto

-- Borrados Datos
DELETE FROM detalle_factura_venta
WHERE FACTURA_VENTA_Id_FacturaVenta=10;

DELETE FROM factura_venta
WHERE Id_FacturaVenta=10;

DELETE FROM detalle_factura_compra
WHERE FACTURA_COMPRA_Id_FacturaCompra=10;

DELETE FROM factura_compra
WHERE Id_FacturaCompra=10;

-- Cambios
UPDATE producto_gasto
SET pro_precio_unitario=3000
WHERE Id_Producto_Gasto=1;

SET SQL_SAFE_UPDATES=1;

UPDATE producto_gasto
SET pro_precio_unitario=3000
WHERE pro_nombre='Detergente';

-- Cambios tabla
ALTER TABLE empleado_has_horario_empleado
RENAME TO empleado_tiene_horario_empleado;

ALTER TABLE factura_venta
ADD fac_ven_domiciliario INT NOT NULL;

ALTER TABLE factura_venta
ADD CONSTRAINT `fk_ID_EMPLEADO`
	FOREIGN KEY (`ID_EMPLEADO`)
    REFERENCES `BD_Proyecto_Tienda`.`empleado` (`Id_Empleado`);

UPDATE factura_venta
SET fac_ven_domiciliario=1000000008
WHERE fac_ven_modo_entrega='Domicilio';