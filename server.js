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
    password: 'BiteMe_2002',
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