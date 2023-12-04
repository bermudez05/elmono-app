const express = require("express");
const cors = require("cors");
const mysql = require("mysql");

const app = express();
const port = 3001;

app.use(cors());
app.use(express.json());

const db_elmono = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    // Aquí va la contraseña de tu mysql
    password: '4Br6gyp63P27',
    database: 'bd_proyecto_tienda',
});

db_elmono.connect((err) => {
    if (err) {
        console.error('Error al conectar a Mysql:', err);
    } else {
        console.log('Conexion a Mysql establecida');
    }
});

// Define tu ruta y endpoints aqui
app.listen(port, () => {
    console.log(`Servidor express escuchando en el puerto ${port}`)
});

// Consultar una vista
app.get("/api/productos", (req, res) => {
    db_elmono.query('SELECT * FROM vw_productos_existentes', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});

app.get("/api/productosfactura", (req, res) => {
    db_elmono.query('select Id_ProductoTienda, pro_nombre, pro_precio_Unitario from vw_productos_existentes group by Id_ProductoTienda;', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});

app.get("/api/clientes", (req, res) => {
    db_elmono.query('SELECT id_numero_identificacion FROM vw_clientes_registrados;', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});

app.get("/api/sucursal1", (req, res) => {
    db_elmono.query('SELECT * FROM vw_info_sucursal_1', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});


// llamamos la vista para ver los productos de gasto disponibles
app.get("/api/productosgasto", (req, res) => {
    db_elmono.query('SELECT * FROM vw_productos_gasto_registrados', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});

// llamamos la vista para ver los proveedores
app.get("/api/proveedor", (req, res) => {
    db_elmono.query('SELECT * FROM vw_proveedores_registrados', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});

app.get("/api/facturasventas", (req, res) => {
    db_elmono.query('SELECT\n' +
        '    CLIENTE_id_numero_identificacion,\n' +
        '    fac_ven_fecha,\n' +
        '    Id_FacturaVenta,\n' +
        '    fac_ven_total_pago,\n' +
        '    fac_ven_metodo_pago,\n' +
        '    fac_ven_descripcion,\n' +
        '    fac_ven_modo_entrega,\n' +
        '    fac_ven_estado_entrega,\n' +
        '    CONCAT_WS(\' \', cli_nombre, cli_apellido) AS nombre_cliente,\n' +
        '    cli_telefono,\n' +
        '    cli_tipo_identificacion,\n' +
        '    SUM(det_cantidad) AS total_cantidad\n' +
        'FROM\n' +
        '    vw_facturas_ventas_registradas\n' +
        'GROUP BY\n' +
        '    CLIENTE_id_numero_identificacion,\n' +
        '    fac_ven_fecha,\n' +
        '    Id_FacturaVenta,\n' +
        '    fac_ven_total_pago,\n' +
        '    fac_ven_metodo_pago,\n' +
        '    fac_ven_descripcion,\n' +
        '    fac_ven_modo_entrega,\n' +
        '    fac_ven_estado_entrega,\n' +
        '    CONCAT_WS(\' \', cli_nombre, cli_apellido),\n' +
        '    cli_telefono,\n' +
        '    cli_tipo_identificacion;', (err, results) => {
        if (err) {
            console.error('Error al consultar la vista', err);
            res.status(500).json({error: 'Error al consultar la vista'});
        } else {
            res.json(results);
        }
    });
});


// Ejecutar un procedimiento almacenado
app.put('/api/updateDeliveryStatus/:facturaId', (req, res) => {

    const facturaId = req.params.facturaId;

    db_elmono.query('CALL sp_ActualizarEstadoEntregaVenta(?)', [facturaId], (err, results) => {
        if (err) {
            console.error('Error al ejecutar el procedimiento para actualizar:', err);
            res.status(500).json({error: 'Error al ejecutar el procedimiento para actualizar'});
        } else {
            res.json({message: 'Estado de entrega actualizado correctamente'});
        }
    });
});


app.post('/api/registrarFacturaVenta', async (req, res) => {
    try {
        const {
            id_numero_identificacion,
            nuevo_cliente,
            fac_ven_descripcion,
            fac_ven_estado_entrega,
            fac_ven_metodo_pago,
            fac_ven_modo_entrega,
            productosform
        } = req.body;

        const fac_ven_total_pago = productosform.reduce((total, product) => total + (product.cantidad * product.precioUnitario), 0)

        let clienteId;

        if (id_numero_identificacion) {
            clienteId = id_numero_identificacion;
        } else if (nuevo_cliente.id_numero_identificacion) {
            // Registrar el nuevo cliente y obtener su ID
            const clienteResults = await registrarNuevoCliente(nuevo_cliente);
            clienteId = nuevo_cliente.id_numero_identificacion;
        }

        // Registrar la factura y obtener su ID
        const facturaResults = await registrarFactura(fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_descripcion, fac_ven_estado_entrega, clienteId, 1000000001);

        const nuevaFacturaId = facturaResults.insertId;

        // Registrar los detalles de la factura
        await Promise.all(productosform.map(producto => registrarDetalleFactura(nuevaFacturaId, producto)));

        res.json({message: 'Factura de venta registrada correctamente'});
    } catch (error) {
        console.error('Error al registrar la factura de venta:', error);
        res.status(500).json({error: 'Error al registrar la factura de venta'});
    }
});

async function registrarNuevoCliente(nuevoCliente) {
    return new Promise((resolve, reject) => {
        db_elmono.query(
            'CALL sp_RegistrarCliente(?, ?, ?, ?, ?, ?, ?)',
            [
                nuevoCliente.id_numero_identificacion,
                nuevoCliente.cli_nombre,
                nuevoCliente.cli_apellido,
                nuevoCliente.cli_telefono,
                nuevoCliente.cli_direccion,
                nuevoCliente.cli_tipo_identificacion,
                nuevoCliente.cli_ciudad
            ],
            (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results);
                }
            }
        );
    });
}

async function registrarFactura(...facturaParams) {
    return new Promise((resolve, reject) => {
        db_elmono.query(
            'INSERT INTO FACTURA_VENTA (fac_ven_fecha, fac_ven_total_pago, fac_ven_modo_entrega, fac_ven_metodo_pago, fac_ven_descripcion, fac_ven_estado_entrega, CLIENTE_id_numero_identificacion, EMPLEADO_Id_Empleado) VALUES (NOW(), ?, ?, ?, ?, ?, ?, ?)',
            facturaParams,
            (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results);
                }
            }
        );
    });
}

async function registrarDetalleFactura(nuevaFacturaId, producto) {
    return new Promise((resolve, reject) => {
        db_elmono.query(
            'CALL sp_RegistrarDetalleFacturaVenta(?, ?, ?, ?)',
            [nuevaFacturaId, producto.idProducto, producto.cantidad, producto.precioUnitario],
            (err, results) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(results);
                }
            }
        );
    });
}