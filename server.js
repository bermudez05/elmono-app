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
    password: '',
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
