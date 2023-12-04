-- Insercion de datos en la Base de datos
USE bd_proyecto_tienda;

-- Insercion datos tabla producto_gasto
INSERT INTO `BD_Proyecto_Tienda`.`PRODUCTO_GASTO` (`Id_Producto_Gasto`, `pro_nombre`, `pro_precio_unitario`, `pro_descripcion`) VALUES
(1, 'Papel higiénico', 2500, 'Papel higiénico doble hoja'),
(2, 'Jabón líquido', 10000, 'Jabón líquido para manos 500ml'),
(3, 'Detergente', 3500, 'Detergente líquido 1L'),
(4, 'Desinfectante', 4000, 'Desinfectante para superficies 1L'),
(5, 'Factura Gas', 0, 'Facturas por mes'),
(6, 'Factura Agua', 0, 'Facturas por mes'),
(7, 'Factura Luz', 0, 'Facturas por mes'),
(8, 'Factura Servicios Generales', 0, 'Facturas servicios generales por mes'),
(9, 'Productos de Oficina', 4000, 'Papel, esferos, cuadernos,..etc');

-- Insercion datos tabla sucursalsucursal
INSERT INTO `BD_Proyecto_Tienda`.`SUCURSAL` (`Id_Sucursal`, `suc_nombre`, `suc_direccion`, `suc_ciudad`, `suc_telefono`, `suc_correo`) VALUES
(1, 'Tienda Central', 'Calle 15 #10-20', 'Villavicencio', 3101234567, 'losmonos@tienda.com'),
(2, 'Sucursal Norte', 'Carrera 5 #50-10', 'Villavicencio', 3101234578, 'losmonos@tienda.com');

-- Insercion datos tabla sucursal
INSERT INTO `BD_Proyecto_Tienda`.`FACTURA_GASTO` (`fac_gas_fecha`, `fac_gas_total_pago`, `fac_gas_modo_entrega`, `fac_gas_metodo_pago`, `fac_gas_descripcion`, `fac_gas_estado_entrega`, `SUCURSAL_Id_Sucursal`) VALUES
('2023-09-15', 300000, 'Presencial', 'Efectivo', 'Pago de servicios generales', 1, 1),
('2023-10-16', 45000, 'Domicilio', 'Tarjeta Crédito', 'Compra productos aseo', 0, 1),
('2023-10-17', 20000, 'Presencial', 'Efectivo', 'Pago factura energía', 1, 2),
('2023-10-18', 15000, 'Domicilio', 'Tarjeta Débito', 'Compra productos oficina', 1, 2),
('2023-10-19', 70000, 'Presencial', 'Efectivo', 'Pago servicios de internet', 1, 1);

-- Insercion de datos tabla datalle factura gasto
INSERT INTO `BD_Proyecto_Tienda`.`DETALLE_FACTURA_GASTO` (`FACTURA_GASTO_Id_Facturagasto`, `PRODUCTO_GASTO_Id_Producto_Gasto`, `det_cantidad`, `det_precio_unitario`) VALUES
(1, 5, 1, 100000), -- 1 productos del tipo 1 a 100000 cada uno
(1, 6, 1, 100000), -- 1 productos del tipo 1 a 100000 cada uno
(1, 7, 1, 100000), -- 1 productos del tipo 1 a 100000 cada uno
(2, 2, 2, 10000),  -- 2 productos del tipo 2 a 5000 cada uno
(2, 1, 4, 5000),  -- 4 productos del tipo 2 a 5000 cada uno
(2, 3, 1, 5000), -- 1 producto del tipo 3 a 20000
(3, 7, 5, 2000),  -- 1 producto del tipo 7 a 2000 cada uno
(4, 9, 1, 5000),  -- 1 producto del tipo 3 a 5000
(5, 8, 1, 70000);  -- 5 productos del tipo 1 a 1000 cada uno

-- Insercion de datos en la tabla empleados para  la sucursal 1
INSERT INTO `BD_Proyecto_Tienda`.`EMPLEADO` (`Id_Empleado`, `emp_cargo`, `emp_sueldo`, `emp_tipo_contrato`, `emp_fecha_inicio_contrato`, `emp_fecha_terminacion_contrato`, `SUCURSAL_Id_Sucursal`) VALUES
(1000000001, 'Tendero', 1000000, 'Fijo', '2023-01-01', '2024-01-01', 1),
(1000000002, 'Tendero', 1000000, 'Fijo', '2023-01-01', '2024-01-01', 1),
(1000000003, 'Domiciliario', 500000, 'Temporal', '2023-01-01', '2023-12-31', 1),
(1000000004, 'Domiciliario', 500000, 'Temporal', '2023-01-01', '2023-12-31', 1),
(1000000005, 'Administrador', 2000000, 'Fijo', '2023-01-01', '2026-01-01', 1);

-- Insercion de datos en la tabla empleados para  la sucursal 1
INSERT INTO `BD_Proyecto_Tienda`.`EMPLEADO` (`Id_Empleado`, `emp_cargo`, `emp_sueldo`, `emp_tipo_contrato`, `emp_fecha_inicio_contrato`, `emp_fecha_terminacion_contrato`, `SUCURSAL_Id_Sucursal`) VALUES
(1000000006, 'Tendero', 1000000, 'Fijo', '2023-01-01', '2024-01-01', 2),
(1000000007, 'Tendero', 1000000, 'Fijo', '2023-01-01', '2024-01-01', 2),
(1000000008, 'Domiciliario', 500000, 'Temporal', '2023-01-01', '2023-12-31', 2),
(1000000009, 'Domiciliario', 500000, 'Temporal', '2023-01-01', '2023-12-31', 2),
(1000000010, 'Administrador', 2000000, 'Fijo', '2023-01-01', '2026-01-01', 2);

-- Insercion de datos en la tabla HORARIO_EMPLEADO
INSERT INTO `BD_Proyecto_Tienda`.`HORARIO_EMPLEADO` (`hre_hora_inicio_jornada`, `hre_hora_salida_jornada`, `hre_dia`) VALUES
('09:00:00', '17:00:00', 'Lunes'),
('09:00:00', '17:00:00', 'Martes'),
('09:00:00', '17:00:00', 'Miércoles'),
('09:00:00', '17:00:00', 'Jueves'),
('09:00:00', '17:00:00', 'Viernes'),
('09:00:00', '17:00:00', 'Sábado'),
('09:00:00', '17:00:00', 'Domingo');

-- Insertamos relaciones en EMPLEADO_has_HORARIO_EMPLEADO
-- Relaciones para los empleados de la sucursal 2
INSERT INTO `BD_Proyecto_Tienda`.`EMPLEADO_has_HORARIO_EMPLEADO` (`EMPLEADO_Id_Empleado`, `HORARIO_EMPLEADO_id_horario`) VALUES
-- Tendero 1
(1000000001, 1),  -- Lunes
(1000000001, 3),  -- Miércoles
(1000000001, 5),  -- Viernes
-- Tendero 2
(1000000002, 2),  -- Martes
(1000000002, 4),  -- Jueves
(1000000002, 6),  -- Sábado
-- Domiciliario 1
(1000000003, 1),  -- Lunes
(1000000003, 2),  -- Martes
-- Domiciliario 2 
(1000000004, 3),  -- Miércoles
(1000000004, 4),  -- Jueves
-- Administrador
(1000000005, 1),  -- Lunes
(1000000005, 2),  -- Martes
(1000000005, 3),  -- Miércoles
(1000000005, 4),  -- Jueves
(1000000005, 5),  -- Viernes
(1000000005, 6),  -- Sábado
(1000000005, 7);  -- Domingo

-- Relaciones para los empleados de la sucursal 2
-- Tendero 3 
INSERT INTO `BD_Proyecto_Tienda`.`EMPLEADO_has_HORARIO_EMPLEADO` (`EMPLEADO_Id_Empleado`, `HORARIO_EMPLEADO_id_horario`) VALUES
(1000000006, 1),  -- Lunes
(1000000006, 4),  -- Jueves
(1000000006, 7),  -- Domingo
-- Tendero 4
(1000000007, 2),  -- Martes
(1000000007, 3),  -- Miércoles
(1000000007, 6),  -- Sábado
-- Domiciliario 3 
(1000000008, 1),  -- Lunes
(1000000008, 2),  -- Martes
(1000000008, 3),  -- Miércoles
(1000000008, 4),  -- Jueves
-- Domiciliario 4 (ID=9)
(1000000009, 5),  -- Viernes
(1000000009, 6),  -- Sábado
(1000000009, 7),  -- Domingo
-- Administrador (ID=10)
(1000000010, 1),  -- Lunes
(1000000010, 2),  -- Martes
(1000000010, 3),  -- Miércoles
(1000000010, 4),  -- Jueves
(1000000010, 5),  -- Viernes
(1000000010, 6),  -- Sábado
(1000000010, 7);  -- Domingo

-- Inserciones para la tabla CLIENTE
INSERT INTO `BD_Proyecto_Tienda`.`CLIENTE` (`id_numero_identificacion`, `cli_nombre`, `cli_apellido`, `cli_telefono`, `cli_direccion`, `cli_tipo_identificacion`, `cli_ciudad`) VALUES
(1012345678, 'Pedro', 'Martinez', NULL, NULL, 'C.C', 'Villavicencio'),
(2098765432, 'Tienda Los Huevos', NULL, 3109876543, 'Carrera 23 #45-67', 'NIT', 'Villavicencio'),
(3156789123, 'Carmen', 'Lopez', 3145678912, NULL, 'C.C', 'Villavicencio'),
(4234567890, 'Distribuidora Huevo Dorado', NULL, 3178901234, 'Diagonal 56 #78-90', 'NIT', 'Villavicencio'),
(5312345678, 'Elena', 'Castro', NULL, NULL, 'C.C', 'Villavicencio'),
(6456789012, 'Empresa Huevo Fresco', NULL, 3123456789, 'Carrera 12 #34-56', 'NIT', 'Villavicencio'),
(7890123456, 'Luis', 'Gomez', 3156789012, 'Avenida 90 #12-34', 'C.C', 'Villavicencio');
-- Inserciones para la tabla FACTURA_VENTA
-- cliente 1012345678
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-28', 10000, 'En Tienda', 'Efectivo', 1, 1000000001, 1012345678);
-- cliente 2098765432
-- Factura 1
INSERT INTO DETALLE_METODO_PAGO (numero_referencia, met_estado_transaccion, met_titular_nombre, met_titular_apellido, met_titular_tipo_doc, met_titular_num_doc)
VALUES (2001, 'Aprobado', 'Tienda Los Huevos', NULL, 'NIT', 2098765432);
INSERT INTO TRANSFERENCIA_BANCARIA (tra_banco, tra_banco_destino, tra_numero_cuenta_destino, tra_titular_cuenta_destino, DETALLE_METODO_PAGO_numero_referencia)
VALUES ('BancoA', 'BancoB', 123456789, 'Tienda El Mono', 2001);
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, DETALLE_METODO_PAGO_numero_referencia, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-28', 150000, 'Domicilio', 'Bancario', 0, 1000000002, 2001, 2098765432);
-- Factura 2
INSERT INTO DETALLE_METODO_PAGO (numero_referencia, met_estado_transaccion, met_titular_nombre, met_titular_apellido, met_titular_tipo_doc, met_titular_num_doc)
VALUES (2002, 'Aprobado', 'Tienda Los Huevos', NULL, 'NIT', 2098765432);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3101234567, 2002);
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, DETALLE_METODO_PAGO_numero_referencia, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-29', 240000, 'Domicilio', 'Movil', 1, 1000000001, 2002, 2098765432);
-- cliente 3156789123
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-30', 12000, 'En Tienda', 'Efectivo', 1, 1000000002, 3156789123);
-- cliente 4234567890
-- Factura 1
INSERT INTO DETALLE_METODO_PAGO (numero_referencia, met_estado_transaccion, met_titular_nombre, met_titular_apellido, met_titular_tipo_doc, met_titular_num_doc)
VALUES (2003, 'Aprobado', 'Distribuidora Huevo Dorado', NULL, 'NIT', 4234567890);
INSERT INTO TRANSFERENCIA_BANCARIA (tra_banco, tra_banco_destino, tra_numero_cuenta_destino, tra_titular_cuenta_destino, DETALLE_METODO_PAGO_numero_referencia)
VALUES ('BancoB', 'Distribuidora Huevo Dorado', 987654321, 'Tienda El Mono', 2003);
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, DETALLE_METODO_PAGO_numero_referencia, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-31', 110000, 'Domicilio', 'Bancario', 0, 1000000002, 2003, 4234567890);
-- Factura 2
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-11-01', 130000, 'En Tienda', 'Efectivo', 1, 1000000001, 4234567890);
-- cliente 5312345678
-- Factura 1
INSERT INTO DETALLE_METODO_PAGO (numero_referencia, met_estado_transaccion, met_titular_nombre, met_titular_apellido, met_titular_tipo_doc, met_titular_num_doc)
VALUES (2004, 'Aprobado', 'Elena', 'Castro', 'CC', 5312345678);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3209876543, 2004);
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, DETALLE_METODO_PAGO_numero_referencia, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-30', 50000, 'En Tienda', 'Movil', 1, 1000000006, 2004, 5312345678);
-- Factura 2
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-11-01', 9500, 'En Tienda', 'Efectivo', 1, 1000000006, 5312345678);
-- cliente 6456789012
-- Factura 1
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-28', 105000, 'En Tienda', 'Efectivo', 1, 1000000007, 6456789012);
-- cliente 7890123456
INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_estado_entrega, EMPLEADO_Id_Empleado, CLIENTE_id_numero_identificacion) 
VALUES ('2023-10-29', 10050, 'En Tienda', 'Efectivo', 1, 1000000007, 7890123456);

-- Insercion de datos para la tabla de productos_tienda
INSERT INTO PRODUCTO_TIENDA (Id_ProductoTienda, pro_nombre, pro_precio_Unitario, pro_descripcion) 
-- Huevos individuales:
VALUES (1, 'Huevo A', 300, 'Huevo de tamaño pequeño, vendido individualmente.'),
(2, 'Huevo AA', 400, 'Huevo de tamaño mediano, vendido individualmente.'),
(3, 'Huevo AAA', 500, 'Huevo de tamaño grande, vendido individualmente.'),
(4, 'Huevo Jumbo', 600, 'Huevo de tamaño jumbo, vendido individualmente.'),
-- Huevos en canastas:
(5, 'Canasta A x30', 9000, 'Canasta de 30 huevos de tamaño pequeño.'),
(6, 'Canasta AA x30', 12000, 'Canasta de 30 huevos de tamaño mediano.'),
(7, 'Canasta AAA x30', 15000, 'Canasta de 30 huevos de tamaño grande.'),
(8, 'Canasta Jumbo x30', 17000, 'Canasta de 30 huevos de tamaño jumbo.');

-- Inserciones de los datos para la tabla LOTE

INSERT INTO LOTE (Id_Lote, lot_cantidad, lot_fecha_caducidad, lot_estado, SUCURSAL_Id_Sucursal, PRODUCTO_TIENDA_Id_ProductoTienda)
-- Lotes para producto 1
VALUES (1, 50, '2023-12-01', 1, 1, 1),
 (2, 100, '2023-12-05', 1, 2, 1),
-- Lotes para producto 2
(3, 30, '2023-12-10', 1, 1, 2),
(4, 100, '2023-12-15', 1, 2, 2),
(5, 50, '2023-12-20', 1, 1, 2),
-- Lotes para producto 3
 (6, 50, '2023-12-03', 1, 1, 3),
 (7, 100, '2023-12-07', 1, 2, 3),
-- Lotes para producto 4
 (8, 80, '2023-12-12', 1, 1, 4),
 (9, 50, '2023-12-17', 1, 2, 4),
 (10, 20, '2023-12-22', 1, 1, 4),
-- Lotes para producto 5
(11, 0, '2023-12-04', 0, 1, 5),
(12, 70, '2023-12-08', 1, 2, 5),
-- Lotes para producto 6
 (13, 100, '2023-12-13', 1, 1, 6),
 (14, 60, '2023-12-18', 1, 2, 6),
-- Lotes para producto 7
(15, 40, '2023-12-05', 1, 1, 7),
(16, 80, '2023-12-09', 1, 2, 7),
-- Lotes para producto 8
(17, 80, '2023-12-14', 1, 1, 8),
(18, 30, '2023-12-19', 1, 2, 8);


-- Insercion datos para la tabla DETALLE_FACTURA_VENTA
INSERT INTO `BD_Proyecto_Tienda`.`DETALLE_FACTURA_VENTA` (FACTURA_VENTA_Id_FacturaVenta, PRODUCTO_TIENDA_Id_ProductoTienda, det_cantidad, det_precio_unitario) VALUES
-- Factura 1, Total: 10000
(1, 1, 33, 300), 
(1, 2, 1, 400),
-- Factura 2, Total: 150000
(2, 5, 10, 9000), 
(2, 6, 5, 12000),
-- Factura 3 , Total: 240000
(3, 7, 8, 15000), 
(3, 8, 6, 17000), 
(3, 1, 200, 300),
-- Factura 4 , Total: 12000
(4, 6, 1, 300),
-- Factura 5 , Total: 110000
(5, 6, 5, 12000), 
(5, 7, 4, 15000), 
(5, 8, 2, 17000),
-- Factura 6 , Total: 130000
(6, 8, 5, 17000), 
(6, 4, 50, 600), 
(6, 3, 50, 500),
-- Factura 7, Total: 50000
(7, 5, 5, 9000), 
(7, 2, 25, 400),
-- Factura 8, Total: 9500
(8, 1, 25, 300), 
(8, 2, 5, 400),
-- Factura 9, Total: 105000
(9, 7, 6, 15000), 
(9, 6, 2, 12000), 
(9, 1, 150, 300),
-- Factura 10 (segunda del mismo ID), Total: 10050
(10, 2, 25, 400);

-- Insercion de datos para la tabla PROVEEDOR
INSERT INTO `BD_Proyecto_Tienda`.`PROVEEDOR` (`Id_numero_identificacion`, `pro_nombre`, `pro_telefono`, `pro_direccion`) VALUES
(100001, 'Distribuidora El Gallo', 3012345678, 'Calle 12 # 34-56'),
(100005, 'Granja Los Pinos', 3056789012, 'Carrera 23 # 45-67'),
(100006, 'Distribuidora Amanecer', 3067890123, 'Calle 56 # 78-90'),
(100007, 'Granja San Pedro', 3078901234, 'Avenida 34 # 56-78');

-- Insercion datos DETALLE_METODO_PAGO 
INSERT INTO DETALLE_METODO_PAGO
(`numero_referencia`, `met_estado_transaccion`, `met_informacion_adicional`, `met_titular_nombre`, `met_titular_apellido`, `met_titular_tipo_doc`, `met_titular_num_doc`) 
VALUES 
(2005, 'Confirmada', 'Transacción de la tienda', 'El Mono', NULL, 'NIT', 2000000001),
(2006, 'Confirmada', 'Transacción con El mono', 'El Mono', NULL, 'NIT', 2000000001),
(2007, 'Confirmada', 'Transacción con El mono', 'El Mono', NULL, 'NIT', 2000000001),
(2008, 'Confirmada', 'Transacción con El mono', 'El Mono', NULL, 'NIT', 2000000001),
(2009, 'Confirmada', 'Transacción con El mono', 'El Mono', NULL, 'NIT', 2000000001),
(2010, 'Confirmada', 'Transacción con El mono', 'El Mono', NULL, 'NIT', 2000000001);

INSERT INTO TRANSFERENCIA_BANCARIA (tra_banco, tra_banco_destino, tra_numero_cuenta_destino, tra_titular_cuenta_destino, DETALLE_METODO_PAGO_numero_referencia)
VALUES ('BancoB', 'Banco A', 987954321, 'Distribuidora Amanecer', 2005);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3056789012, 2006);
INSERT INTO TRANSFERENCIA_BANCARIA (tra_banco, tra_banco_destino, tra_numero_cuenta_destino, tra_titular_cuenta_destino, DETALLE_METODO_PAGO_numero_referencia)
VALUES ('BancoB', 'BancoA', 657954321, 'Granja Los Pinos', 2007);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3012345678, 2008);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3067890123, 2009);
INSERT INTO TRANSFERENCIA_MOVIL (tra_mov_numero_telefono, DETALLE_METODO_PAGO_numero_referencia)
VALUES (3078901234, 2010);

-- Insercón de datos FACTURA_COMPRA
INSERT INTO FACTURA_COMPRA
(`fac_com_fecha`, `fac_com_total_pago`, `fac_com_modo_entrega`, `fac_com_metodo_pago`, `fac_com_descripcion`, `fac_com_estado_entrega`, `DETALLE_METODO_PAGO_numero_referenca`, `PROVEEDOR_Id_numero_identificacion`) 
VALUES 
('2023-10-28', 20000, 'En Bodega', 'Efectivo', 'Compra de huevos A', 1, NULL, 100001),
('2023-10-29', 300000, 'Domicilio', 'Bancario', 'Compra de huevos AA', 0, 2005, 100006),
('2023-10-30', 50000, 'Domicilio', 'Efectivo', 'Compra mixta de huevos', 1, NULL, 100007),
('2023-10-31', 15000, 'En Bodega', 'Movil', 'Compra de huevos AAA', 1, 2006, 100005),
('2023-11-01', 220000, 'Domicilio', 'Bancario', 'Compra de canasta AA x30', 0, 2007, 100005),
('2023-11-02', 60000, 'En Bodega', 'Efectivo', 'Compra de huevos Jumbo', 1, NULL, 100007),
('2023-11-03', 120000, 'Domicilio', 'Movil', 'Compra de canasta A x30', 1, 2008, 100001),
('2023-11-04', 75000, 'En Bodega', 'Efectivo', 'Compra de canasta Jumbo x30', 1, NULL, 100001),
('2023-11-05', 90000, 'Domicilio', 'Movil', 'Compra mixta de huevos', 0, 2009, 100006),
('2023-11-06', 80000, 'En Bodega', 'Movil', 'Compra de huevos AAA', 1, 2010, 100007);

-- Inserción datos DETALLE_FACTURA_COMPRA
INSERT INTO `BD_Proyecto_Tienda`.`DETALLE_FACTURA_COMPRA` 
(`FACTURA_COMPRA_Id_FacturaCompra`, `PRODUCTO_TIENDA_Id_ProductoTienda`, `det_cantidad`, `det_precio_unitario`) 
VALUES 
(1, 1, 66, 300),
(1, 4, 1, 600),
(2, 2, 750, 400),
(3, 2, 100, 400),
(3, 1, 20, 300),
(3, 3, 4, 500),
(3, 5, 1, 9000),
(4, 3, 30, 500),
(5, 6, 18, 12000),
(5, 2, 4, 400),
(6, 4, 100, 600),
(7, 5, 13, 9000),
(7, 1, 5, 300),
(8, 8, 4, 17000),
(8, 4, 11, 600),
(9, 5, 5, 9000),
(9, 6, 5, 12000),
(10, 3, 160, 500);



