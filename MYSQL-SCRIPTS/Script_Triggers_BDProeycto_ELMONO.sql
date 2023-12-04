USE bd_proyecto_tienda;

DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_FACTURA_VENTA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_FACTURA_VENTA` (
  `Id_FacturaVentaBorrada` INT NOT NULL AUTO_INCREMENT,
  `time_stamp_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Id_FacturaVenta` INT NOT NULL,
  `fac_ven_fecha` DATE NOT NULL,
  `fac_ven_total_pago` INT NOT NULL,
  `fac_ven_modo_entrega` VARCHAR(45) NOT NULL,
  `fac_ven_metodo_pago` VARCHAR(25) NOT NULL,
  `fac_ven_descripcion` VARCHAR(80) NULL,
  `fac_ven_estado_entrega` TINYINT(1) NOT NULL,
  `DETALLE_METODO_PAGO_numero_referencia` BIGINT NULL,
  `CLIENTE_id_numero_identificacion` BIGINT NOT NULL,
  `EMPLEADO_Id_Empleado` BIGINT NOT NULL,
  PRIMARY KEY (`Id_FacturaVentaBorrada`))
ENGINE = InnoDB;

DROP TRIGGER IF EXISTS guardar_registro_borrado_factura_venta;

DELIMITER $$
CREATE TRIGGER guardar_registro_borrado_factura_venta
AFTER DELETE ON BD_Proyecto_Tienda.FACTURA_VENTA
FOR EACH ROW
BEGIN
    INSERT INTO BD_Proyecto_Tienda.Registro_Borrados_FACTURA_VENTA (
		Id_FacturaVenta, 
        fac_ven_fecha, fac_ven_total_pago, 
        fac_ven_modo_entrega, 
        fac_ven_metodo_pago, 
        fac_ven_descripcion, 
        fac_ven_estado_entrega, 
        DETALLE_METODO_PAGO_numero_referencia, 
        CLIENTE_id_numero_identificacion, 
        EMPLEADO_Id_Empleado)
    VALUES (
		OLD.Id_FacturaVenta, 
        OLD.fac_ven_fecha, 
        OLD.fac_ven_total_pago, 
        OLD.fac_ven_modo_entrega, 
        OLD.fac_ven_metodo_pago, 
        OLD.fac_ven_descripcion, 
        OLD.fac_ven_estado_entrega, 
        OLD.DETALLE_METODO_PAGO_numero_referencia, 
        OLD.CLIENTE_id_numero_identificacion, 
        OLD.EMPLEADO_Id_Empleado);
END;
$$ DELIMITER ;

DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_DETALLE_FACTURA_VENTA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_DETALLE_FACTURA_VENTA` (
  `Id_detalle_factura_venta_borrada` INT NOT NULL AUTO_INCREMENT,
  `time_stamp_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FACTURA_VENTA_Id_FacturaVenta` INT NOT NULL,
  `PRODUCTO_TIENDA_Id_ProductoTienda` INT NOT NULL,
  `det_cantidad` INT NOT NULL,
  `det_precio_unitario` INT NOT NULL,
  PRIMARY KEY (`Id_detalle_factura_venta_borrada`))
ENGINE = InnoDB;

DROP TRIGGER IF EXISTS guardar_registro_borrado_DETALLE_FACTURA_VENTA;

DELIMITER //
CREATE TRIGGER guardar_registro_borrado_DETALLE_FACTURA_VENTA
AFTER DELETE ON BD_Proyecto_Tienda.DETALLE_FACTURA_VENTA
FOR EACH ROW
BEGIN
    INSERT INTO BD_Proyecto_Tienda.Registro_Borrados_DETALLE_FACTURA_VENTA (
		FACTURA_VENTA_Id_FacturaVenta, 
        PRODUCTO_TIENDA_Id_ProductoTienda, 
        det_cantidad, 
        det_precio_unitario)
    VALUES (
		OLD.FACTURA_VENTA_Id_FacturaVenta, 
        OLD.PRODUCTO_TIENDA_Id_ProductoTienda, 
        OLD.det_cantidad, 
        OLD.det_precio_unitario);
END;
// DELIMITER ;

DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_FACTURA_COMPRA`;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`Registro_Borrados_FACTURA_COMPRA` (
  `Id_detalle_factura_compra_borrada` INT NOT NULL AUTO_INCREMENT,
  `time_stamp_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Id_FacturaCompra` INT NOT NULL,
  `fac_com_fecha` DATE NOT NULL,
  `fac_com_total_pago` INT NOT NULL,
  `fac_com_modo_entrega` VARCHAR(45) NOT NULL,
  `fac_com_metodo_pago` VARCHAR(25) NOT NULL,
  `fac_com_descripcion` VARCHAR(80) NULL,
  `fac_com_estado_entrega` TINYINT(1) NOT NULL,
  `DETALLE_METODO_PAGO_numero_referenca` BIGINT NULL,
  `PROVEEDOR_Id_numero_identificacion` BIGINT NOT NULL,
PRIMARY KEY (`Id_detalle_factura_compra_borrada`));

DROP TRIGGER IF EXISTS guardar_registro_borrado_factura_compra;

DELIMITER //
CREATE TRIGGER guardar_registro_borrado_factura_compra
AFTER DELETE ON BD_Proyecto_Tienda.FACTURA_COMPRA
FOR EACH ROW
BEGIN
    INSERT INTO BD_Proyecto_Tienda.Registro_Borrados_FACTURA_COMPRA (
		Id_FacturaCompra, 
        fac_com_fecha, 
        fac_com_total_pago, 
        fac_com_modo_entrega, 
        fac_com_metodo_pago, 
        fac_com_descripcion, 
        fac_com_estado_entrega, 
        DETALLE_METODO_PAGO_numero_referenca, 
        PROVEEDOR_Id_numero_identificacion)
    VALUES (
		OLD.Id_FacturaCompra, 
        OLD.fac_com_fecha, 
        OLD.fac_com_total_pago, 
        OLD.fac_com_modo_entrega, 
        OLD.fac_com_metodo_pago, 
        OLD.fac_com_descripcion, 
        OLD.fac_com_estado_entrega, 
        OLD.DETALLE_METODO_PAGO_numero_referenca, 
        OLD.PROVEEDOR_Id_numero_identificacion);
END;
// DELIMITER ;

DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`guardar_registro_borrado_detalle_factura_compra` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`guardar_registro_borrado_detalle_factura_compra` (
  `Id_detalle_factura_compra_borrada` INT NOT NULL AUTO_INCREMENT,
  `time_stamp_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `FACTURA_COMPRA_Id_FacturaCompra` INT NOT NULL,
  `PRODUCTO_TIENDA_Id_ProductoTienda` INT NOT NULL,
  `det_cantidad` INT NOT NULL,
  `det_precio_unitario` INT NOT NULL,
PRIMARY KEY (`Id_detalle_factura_compra_borrada`));

DROP TRIGGER IF EXISTS guardar_registro_borrado_detalle_factura_compra;

DELIMITER $$
CREATE TRIGGER guardar_registro_borrado_detalle_factura_compra
AFTER DELETE ON BD_Proyecto_Tienda.DETALLE_FACTURA_COMPRA
FOR EACH ROW
BEGIN
    INSERT INTO BD_Proyecto_Tienda.Registro_Borrados_DETALLE_FACTURA_COMPRA (FACTURA_COMPRA_Id_FacturaCompra, PRODUCTO_TIENDA_Id_ProductoTienda, det_cantidad, det_precio_unitario)
    VALUES (OLD.FACTURA_COMPRA_Id_FacturaCompra, OLD.PRODUCTO_TIENDA_Id_ProductoTienda, OLD.det_cantidad, OLD.det_precio_unitario);
END;
$$ DELIMITER ;

  