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
            <table className="min-w-full divide-y divide-color2">
                <thead className="bg-color2 text-gray-500 text-sm">
                <tr>
                    <th className="py-5 text-center rtl:text-right">ID producto</th>
                    <th className="py-5 text-center rtl:text-right">ID sucursal</th>
                    <th className="py-5 text-center rtl:text-right">Nombre producto</th>
                    <th className="py-5 text-center rtl:text-right">Precio unitario</th>
                    <th className="py-5 text-center rtl:text-right">Cantidad</th>
                    <th className="py-5 text-center rtl:text-right">Descripción</th>
                </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-100 text-sm">
                {productos.map((producto) => (
                    <tr key={producto.Id_ProductoTienda}>
                        <td className="py-3 whitespace-nowrap text-center ">{producto.Id_ProductoTienda}</td>
                        <td className="py-3 whitespace-nowrap text-center ">{producto.SUCURSAL_Id_Sucursal}</td>
                        <td className="py-3 whitespace-nowrap text-center ">{producto.pro_nombre}</td>
                        <td className="py-3 whitespace-nowrap text-center ">${producto.pro_precio_Unitario}</td>
                        <td className="py-3 whitespace-nowrap text-center ">{producto.lot_cantidad}</td>
                        <td className="py-3 whitespace-nowrap text-center ">{producto.pro_descripcion}</td>
                    </tr>
                ))}
                </tbody>
            </table>
        </div>
    )
}

export default ProductsView;