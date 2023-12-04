-- Creacion de la base de datos para la tienda y distribuidora de huevos el mono

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_Proyecto_Tienda
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `BD_Proyecto_Tienda` ;

-- -----------------------------------------------------
-- Schema BD_Proyecto_Tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_Proyecto_Tienda` DEFAULT CHARACTER SET utf8 ;
USE `BD_Proyecto_Tienda` ;

-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` (
  `numero_referencia` BIGINT NOT NULL,
  `met_estado_transaccion` VARCHAR(10) NOT NULL,
  `met_informacion_adicional` VARCHAR(40) NULL,
  `met_titular_nombre` VARCHAR(40) NOT NULL,
  `met_titular_apellido` VARCHAR(20) NULL,
  `met_titular_tipo_doc` VARCHAR(30) NOT NULL,
  `met_titular_num_doc` BIGINT NOT NULL,
  PRIMARY KEY (`numero_referencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`CLIENTE` (
  `id_numero_identificacion` BIGINT NOT NULL,
  `cli_nombre` VARCHAR(30) NOT NULL,
  `cli_apellido` VARCHAR(30) NULL,
  `cli_telefono` BIGINT NULL,
  `cli_direccion` VARCHAR(45) NULL,
  `cli_tipo_identificacion` VARCHAR(20) NOT NULL,
  `cli_ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_numero_identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`SUCURSAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`SUCURSAL` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`SUCURSAL` (
  `Id_Sucursal` INT NOT NULL,
  `suc_nombre` VARCHAR(30) NOT NULL,
  `suc_direccion` VARCHAR(30) NOT NULL,
  `suc_ciudad` VARCHAR(30) NOT NULL,
  `suc_telefono` BIGINT NOT NULL,
  `suc_correo` VARCHAR(30) NULL,
  PRIMARY KEY (`Id_Sucursal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`EMPLEADO` (
  `Id_Empleado` BIGINT NOT NULL,
  `emp_cargo` VARCHAR(30) NOT NULL,
  `emp_sueldo` INT NOT NULL,
  `emp_tipo_contrato` VARCHAR(30) NOT NULL,
  `emp_fecha_inicio_contrato` DATE NOT NULL,
  `emp_fecha_terminacion_contrato` DATE NOT NULL,
  `SUCURSAL_Id_Sucursal` INT NOT NULL,
  PRIMARY KEY (`Id_Empleado`),
  INDEX `fk_EMPLEADO_SUCURSAL1_idx` (`SUCURSAL_Id_Sucursal` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEADO_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_Id_Sucursal`)
    REFERENCES `BD_Proyecto_Tienda`.`SUCURSAL` (`Id_Sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`FACTURA_VENTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`FACTURA_VENTA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`FACTURA_VENTA` (
  `Id_FacturaVenta` INT NOT NULL AUTO_INCREMENT,
  `fac_ven_fecha` DATE NOT NULL,
  `fac_ven_total_pago` INT NOT NULL,
  `fac_ven_modo_entrega` VARCHAR(45) NOT NULL,
  `fac_ven_metodo_pago` VARCHAR(25) NOT NULL,
  `fac_ven_descripcion` VARCHAR(80) NULL,
  `fac_ven_estado_entrega` TINYINT(1) NOT NULL,
  `DETALLE_METODO_PAGO_numero_referencia` BIGINT NULL,
  `CLIENTE_id_numero_identificacion` BIGINT NOT NULL,
  `EMPLEADO_Id_Empleado` BIGINT NOT NULL,
  PRIMARY KEY (`Id_FacturaVenta`),
  INDEX `fk_FACTURA_VENTA_DETALLE_METODO_PAGO1_idx` (`DETALLE_METODO_PAGO_numero_referencia` ASC) VISIBLE,
  INDEX `fk_FACTURA_VENTA_CLIENTE1_idx` (`CLIENTE_id_numero_identificacion` ASC) VISIBLE,
  INDEX `fk_FACTURA_VENTA_EMPLEADO1_idx` (`EMPLEADO_Id_Empleado` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_VENTA_DETALLE_METODO_PAGO1`
    FOREIGN KEY (`DETALLE_METODO_PAGO_numero_referencia`)
    REFERENCES `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` (`numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURA_VENTA_CLIENTE1`
    FOREIGN KEY (`CLIENTE_id_numero_identificacion`)
    REFERENCES `BD_Proyecto_Tienda`.`CLIENTE` (`id_numero_identificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURA_VENTA_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_Id_Empleado`)
    REFERENCES `BD_Proyecto_Tienda`.`EMPLEADO` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`HORARIO_EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`HORARIO_EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`HORARIO_EMPLEADO` (
  `id_horario` INT NOT NULL AUTO_INCREMENT,
  `hre_hora_inicio_jornada` TIME NOT NULL,
  `hre_hora_salida_jornada` TIME NOT NULL,
  `hre_dia` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_horario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`EMPLEADO_has_HORARIO_EMPLEADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`EMPLEADO_has_HORARIO_EMPLEADO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`EMPLEADO_has_HORARIO_EMPLEADO` (
  `HORARIO_EMPLEADO_id_horario` INT NOT NULL,
  `EMPLEADO_Id_Empleado` BIGINT NOT NULL,
  PRIMARY KEY (`HORARIO_EMPLEADO_id_horario`, `EMPLEADO_Id_Empleado`),
  INDEX `fk_EMPLEADO_has_HORARIO_EMPLEADO_HORARIO_EMPLEADO1_idx` (`HORARIO_EMPLEADO_id_horario` ASC) VISIBLE,
  INDEX `fk_EMPLEADO_has_HORARIO_EMPLEADO_EMPLEADO1_idx` (`EMPLEADO_Id_Empleado` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEADO_has_HORARIO_EMPLEADO_HORARIO_EMPLEADO1`
    FOREIGN KEY (`HORARIO_EMPLEADO_id_horario`)
    REFERENCES `BD_Proyecto_Tienda`.`HORARIO_EMPLEADO` (`id_horario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_has_HORARIO_EMPLEADO_EMPLEADO1`
    FOREIGN KEY (`EMPLEADO_Id_Empleado`)
    REFERENCES `BD_Proyecto_Tienda`.`EMPLEADO` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA` (
  `Id_ProductoTienda` INT NOT NULL,
  `pro_nombre` VARCHAR(20) NOT NULL,
  `pro_precio_Unitario` INT NOT NULL,
  `pro_descripcion` VARCHAR(60) NULL,
  PRIMARY KEY (`Id_ProductoTienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`LOTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`LOTE` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`LOTE` (
  `Id_Lote` INT NOT NULL,
  `lot_cantidad` INT NOT NULL,
  `lot_fecha_caducidad` DATE NOT NULL,
  `lot_estado` INT NOT NULL,
  `SUCURSAL_Id_Sucursal` INT NOT NULL,
  `PRODUCTO_TIENDA_Id_ProductoTienda` INT NOT NULL,
  PRIMARY KEY (`Id_Lote`),
  INDEX `fk_LOTE_SUCURSAL1_idx` (`SUCURSAL_Id_Sucursal` ASC) VISIBLE,
  INDEX `fk_LOTE_PRODUCTO_TIENDA1_idx` (`PRODUCTO_TIENDA_Id_ProductoTienda` ASC) VISIBLE,
  CONSTRAINT `fk_LOTE_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_Id_Sucursal`)
    REFERENCES `BD_Proyecto_Tienda`.`SUCURSAL` (`Id_Sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LOTE_PRODUCTO_TIENDA1`
    FOREIGN KEY (`PRODUCTO_TIENDA_Id_ProductoTienda`)
    REFERENCES `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA` (`Id_ProductoTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`DETALLE_FACTURA_VENTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_VENTA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_VENTA` (
  `FACTURA_VENTA_Id_FacturaVenta` INT NOT NULL,
  `PRODUCTO_TIENDA_Id_ProductoTienda` INT NOT NULL,
  `det_cantidad` INT NOT NULL,
  `det_precio_unitario` INT NOT NULL,
  PRIMARY KEY (`FACTURA_VENTA_Id_FacturaVenta`, `PRODUCTO_TIENDA_Id_ProductoTienda`),
  INDEX `fk_FACTURA_VENTA_has_PRODUCTO_TIENDA_PRODUCTO_TIENDA1_idx` (`PRODUCTO_TIENDA_Id_ProductoTienda` ASC) VISIBLE,
  INDEX `fk_FACTURA_VENTA_has_PRODUCTO_TIENDA_FACTURA_VENTA1_idx` (`FACTURA_VENTA_Id_FacturaVenta` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_VENTA_has_PRODUCTO_TIENDA_FACTURA_VENTA1`
    FOREIGN KEY (`FACTURA_VENTA_Id_FacturaVenta`)
    REFERENCES `BD_Proyecto_Tienda`.`FACTURA_VENTA` (`Id_FacturaVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURA_VENTA_has_PRODUCTO_TIENDA_PRODUCTO_TIENDA1`
    FOREIGN KEY (`PRODUCTO_TIENDA_Id_ProductoTienda`)
    REFERENCES `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA` (`Id_ProductoTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`FACTURA_GASTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`FACTURA_GASTO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`FACTURA_GASTO` (
  `Id_Facturagasto` INT NOT NULL AUTO_INCREMENT,
  `fac_gas_fecha` DATE NOT NULL,
  `fac_gas_total_pago` INT NOT NULL,
  `fac_gas_modo_entrega` VARCHAR(45) NOT NULL,
  `fac_gas_metodo_pago` VARCHAR(25) NOT NULL,
  `fac_gas_descripcion` VARCHAR(80) NULL,
  `fac_gas_estado_entrega` TINYINT(1) NOT NULL,
  `SUCURSAL_Id_Sucursal` INT NOT NULL,
  PRIMARY KEY (`Id_Facturagasto`),
  INDEX `fk_FACTURA_GASTO_SUCURSAL1_idx` (`SUCURSAL_Id_Sucursal` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_GASTO_SUCURSAL1`
    FOREIGN KEY (`SUCURSAL_Id_Sucursal`)
    REFERENCES `BD_Proyecto_Tienda`.`SUCURSAL` (`Id_Sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`PRODUCTO_GASTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`PRODUCTO_GASTO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`PRODUCTO_GASTO` (
  `Id_Producto_Gasto` INT NOT NULL,
  `pro_nombre` VARCHAR(30) NOT NULL,
  `pro_precio_unitario` INT NULL,
  `pro_descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Producto_Gasto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`DETALLE_FACTURA_GASTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_GASTO` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_GASTO` (
  `FACTURA_GASTO_Id_FacturagASTO` INT NOT NULL,
  `PRODUCTO_GASTO_Id_Producto_Gasto` INT NOT NULL,
  `det_cantidad` INT NOT NULL,
  `det_precio_unitario` INT NOT NULL,
  PRIMARY KEY (`FACTURA_GASTO_Id_FacturagASTO`, `PRODUCTO_GASTO_Id_Producto_Gasto`),
  INDEX `fk_EMPLEADO_has_FACTURA_GASTO_FACTURA_GASTO1_idx` (`FACTURA_GASTO_Id_FacturagASTO` ASC) VISIBLE,
  INDEX `fk_DETALLE_FACTURA_GASTO_PRODUCTO_GASTO1_idx` (`PRODUCTO_GASTO_Id_Producto_Gasto` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLEADO_has_FACTURA_GASTO_FACTURA_GASTO1`
    FOREIGN KEY (`FACTURA_GASTO_Id_FacturagASTO`)
    REFERENCES `BD_Proyecto_Tienda`.`FACTURA_GASTO` (`Id_Facturagasto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DETALLE_FACTURA_GASTO_PRODUCTO_GASTO1`
    FOREIGN KEY (`PRODUCTO_GASTO_Id_Producto_Gasto`)
    REFERENCES `BD_Proyecto_Tienda`.`PRODUCTO_GASTO` (`Id_Producto_Gasto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`PROVEEDOR` (
  `Id_numero_identificacion` BIGINT NOT NULL,
  `pro_nombre` VARCHAR(30) NOT NULL,
  `pro_telefono` BIGINT NULL,
  `pro_direccion` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_numero_identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`FACTURA_COMPRA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`FACTURA_COMPRA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`FACTURA_COMPRA` (
  `Id_FacturaCompra` INT NOT NULL AUTO_INCREMENT,
  `fac_com_fecha` DATE NOT NULL,
  `fac_com_total_pago` INT NOT NULL,
  `fac_com_modo_entrega` VARCHAR(45) NOT NULL,
  `fac_com_metodo_pago` VARCHAR(25) NOT NULL,
  `fac_com_descripcion` VARCHAR(80) NULL,
  `fac_com_estado_entrega` TINYINT(1) NOT NULL,
  `DETALLE_METODO_PAGO_numero_referenca` BIGINT NULL,
  `PROVEEDOR_Id_numero_identificacion` BIGINT NOT NULL,
  PRIMARY KEY (`Id_FacturaCompra`),
  INDEX `fk_FACTURA_COMPRA_DETALLE_METODO_PAGO1_idx` (`DETALLE_METODO_PAGO_numero_referenca` ASC) VISIBLE,
  INDEX `fk_FACTURA_COMPRA_PROVEEDOR1_idx` (`PROVEEDOR_Id_numero_identificacion` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_COMPRA_DETALLE_METODO_PAGO1`
    FOREIGN KEY (`DETALLE_METODO_PAGO_numero_referenca`)
    REFERENCES `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` (`numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURA_COMPRA_PROVEEDOR1`
    FOREIGN KEY (`PROVEEDOR_Id_numero_identificacion`)
    REFERENCES `BD_Proyecto_Tienda`.`PROVEEDOR` (`Id_numero_identificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`DETALLE_FACTURA_COMPRA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_COMPRA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`DETALLE_FACTURA_COMPRA` (
  `FACTURA_COMPRA_Id_FacturaCompra` INT NOT NULL,
  `PRODUCTO_TIENDA_Id_ProductoTienda` INT NOT NULL,
  `det_cantidad` INT NOT NULL,
  `det_precio_unitario` INT NOT NULL,
  PRIMARY KEY (`FACTURA_COMPRA_Id_FacturaCompra`, `PRODUCTO_TIENDA_Id_ProductoTienda`),
  INDEX `fk_FACTURA_COMPRA_has_PRODUCTO_TIENDA_PRODUCTO_TIENDA1_idx` (`PRODUCTO_TIENDA_Id_ProductoTienda` ASC) VISIBLE,
  INDEX `fk_FACTURA_COMPRA_has_PRODUCTO_TIENDA_FACTURA_COMPRA1_idx` (`FACTURA_COMPRA_Id_FacturaCompra` ASC) VISIBLE,
  CONSTRAINT `fk_FACTURA_COMPRA_has_PRODUCTO_TIENDA_FACTURA_COMPRA1`
    FOREIGN KEY (`FACTURA_COMPRA_Id_FacturaCompra`)
    REFERENCES `BD_Proyecto_Tienda`.`FACTURA_COMPRA` (`Id_FacturaCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURA_COMPRA_has_PRODUCTO_TIENDA_PRODUCTO_TIENDA1`
    FOREIGN KEY (`PRODUCTO_TIENDA_Id_ProductoTienda`)
    REFERENCES `BD_Proyecto_Tienda`.`PRODUCTO_TIENDA` (`Id_ProductoTienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`TRANSFERENCIA_BANCARIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`TRANSFERENCIA_BANCARIA` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`TRANSFERENCIA_BANCARIA` (
  `tra_banco` VARCHAR(30) NOT NULL,
  `tra_banco_destino` VARCHAR(30) NOT NULL,
  `tra_numero_cuenta_destino` INT NOT NULL,
  `tra_titular_cuenta_destino` VARCHAR(45) NOT NULL,
  `DETALLE_METODO_PAGO_numero_referencia` BIGINT NOT NULL,
  INDEX `fk_TRANSFERENCIA_BANCARIA_DETALLE_METODO_PAGO1_idx` (`DETALLE_METODO_PAGO_numero_referencia` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSFERENCIA_BANCARIA_DETALLE_METODO_PAGO1`
    FOREIGN KEY (`DETALLE_METODO_PAGO_numero_referencia`)
    REFERENCES `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` (`numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_Proyecto_Tienda`.`TRANSFERENCIA_MOVIL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_Proyecto_Tienda`.`TRANSFERENCIA_MOVIL` ;

CREATE TABLE IF NOT EXISTS `BD_Proyecto_Tienda`.`TRANSFERENCIA_MOVIL` (
  `tra_mov_numero_telefono` BIGINT NOT NULL,
  `DETALLE_METODO_PAGO_numero_referencia` BIGINT NOT NULL,
  INDEX `fk_TRANSFERENCIA_MOVIL_DETALLE_METODO_PAGO1_idx` (`DETALLE_METODO_PAGO_numero_referencia` ASC) VISIBLE,
  CONSTRAINT `fk_TRANSFERENCIA_MOVIL_DETALLE_METODO_PAGO1`
    FOREIGN KEY (`DETALLE_METODO_PAGO_numero_referencia`)
    REFERENCES `BD_Proyecto_Tienda`.`DETALLE_METODO_PAGO` (`numero_referencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
