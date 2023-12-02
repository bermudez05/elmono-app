import {useEffect, useState} from "react";
import axios from "axios";

function ProductsView() {

    const [productos, setProductos] = useState([])

    useEffect(() => {
        // Realiza una solicitud GET al servidor para obtener datos
        axios.get('http://localhost:3001/api/productos')
            .then((response) => {
                setProductos(response.data);
                console.log(response.data);
            })
            .catch((error) => {
                console.error('Error al obtener datos:', error);
            });
    }, []);

    return (
        <div className="w-3/4 p-5">
            <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-200 text-gray-700 font-bold text-lg">
                <tr>
                    <th className="py-3.5 px-4 font-normal text-left rtl:text-right">Nombre
                        Producto
                    </th>
                    <th className="px-12 py-3.5 font-normal text-left rtl:text-right">Precio
                        Unitario
                    </th>
                    <th className="px-4 py-3.5 font-normal text-left rtl:text-right">Descripción</th>
                </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                {productos.map((producto) => (
                    <tr key={producto.Id_ProductoTienda}>
                        <td className="px-4 py-4 whitespace-nowrap">{producto.pro_nombre}</td>
                        <td className="px-12 py-4 whitespace-nowrap">$ {producto.pro_precio_Unitario}</td>
                        <td className="px-4 py-4 whitespace-nowrap">{producto.pro_descripcion}</td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    )
}

export default ProductsView;