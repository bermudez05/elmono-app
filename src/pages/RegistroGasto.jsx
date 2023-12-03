import {useEffect, useState} from "react";
import axios from "axios";
import { Formik, Form, Field, ErrorMessage } from 'formik';

function RegistroGasto() {

    const [sucursal1, setSucursal1] = useState([])

    useEffect(() => {
        // Realiza una solicitud GET al servidor para obtener datos
        axios.get('http://localhost:3001/api/sucursal1')
            .then((response) => {
                setSucursal1(response.data);
                console.log(response.data);
            })
            .catch((error) => {
                console.error('Error al obtener datos:', error);
            });
    }, []);

    return(
        <div className="flex w-3/4 h-full items-center justify-center bg-color1">
            <div className="flex flex-col w-4/6 h-5/6 rounded-md bg-color2 bg-opacity-60">
            <h3 className="text-center text-base font-bold">Distribuidora de huevos el mono</h3>
            {sucursal1.map((sucursal) => (
                <div key={sucursal.Id_Sucursal}>
                    <p className="text-center text-base font-bold">{sucursal.suc_direccion},{sucursal.suc_ciudad} - {sucursal.suc_nombre}</p>
                    <p className="text-center text-base font-bold">{sucursal.suc_correo} - {sucursal.suc_telefono}</p>
                </div>
            ))}
            </div>
        </div>
    );
}

export default RegistroGasto;