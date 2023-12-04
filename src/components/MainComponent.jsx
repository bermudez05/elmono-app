import React, {useState, useEffect} from "react";
import axios from "axios";

function MainComponent() {
    const [data, setDate] = useState([]);

    useEffect(() => {
        axios.get('http://127.0.0.1:3002/api/clientesNombre')
            .then((response) => {
                setDate(response.data);
            })
            .catch((error) => {
                console.log('Error al obtener datos', error);
            })
    }, []);

    return (
        <div className="w-3/4 p-5">
            <button className="mb-4 px-5 py-3 bg-color2 text-white">
                Registrar gasto
            </button>
            <button className="px-5 py-3 bg-color2 text-white">
                Registrar compra
            </button>
        </div>
    )
}

export default MainComponent;