import {useEffect, useState} from "react";
import axios from "axios";

function FacturasView() {

    const [facturas, setFacturas] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        axios.get('http://localhost:3001/api/facturasventas')
            .then((response) => {
                setFacturas(response.data);
                setLoading(false);
            })
            .catch((error) => {
                console.error('Error al obtener datos:', error);
                setLoading(false);
            });
    }, []);

    if (loading) {
        return <div>Loading...</div>;
    }

    const handleUpdateStatus = async (facturaId) => {
        try {
            // Make an API call to update the delivery status
            await axios.put(`http://localhost:3001/api/updateDeliveryStatus/${facturaId}`);

            // Refresh the facturas data after the update
            const updatedFacturas = await axios.get('http://localhost:3001/api/facturasventas');
            setFacturas(updatedFacturas.data);
        } catch (error) {
            console.error('Error updating delivery status:', error);
        }
    };


    const renderFacturas = () => (
        <div className="grid grid-cols-2 ">
            {facturas.map((factura, index) => (
                <div key={index} className="max-w-md m-5 overflow-hidden bg-gray-100 rounded-lg shadow-lg">
                    <div className="flex items-center px-6 py-3 bg-gray-900">
                        <h1 className="mx-3 text-lg font-semibold text-white">Factura No.
                            {factura.Id_FacturaVenta}
                        </h1>
                    </div>

                    <div className="px-6 py-4">
                        <h1 className="text-lg font-semibold text-gray-800">Detalle Factura</h1>

                        <div className="flex items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base"><span
                                className="font-bold">Fecha Registro:</span> {factura.fac_ven_fecha}</h1>
                        </div>

                        <div className="flex items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span className="font-bold">Nombre Cliente:</span> {factura.nombre_cliente}</h1>
                        </div>

                        <div className="flex items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span
                                    className="font-bold">Identificación Cliente:</span> {factura.cli_tipo_identificacion} {factura.CLIENTE_id_numero_identificacion}
                            </h1>
                        </div>

                        <div className="flex items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span className="font-bold">Teléfono Cliente:</span> {factura.cli_telefono}</h1>
                        </div>
                        <div className="flex flex-row items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span className="font-bold">Modo Entrega:</span> {factura.fac_ven_modo_entrega}</h1>
                            <h1 className="px-2 text-base"><span
                                className="font-bold">Estado Entrega:</span> {factura.fac_ven_estado_entrega}</h1>
                        </div>
                        <div className="items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span className="font-bold">Modo Pago:</span> {factura.fac_ven_metodo_pago}</h1>
                        </div>
                        <div className="items-center mt-4 text-gray-700">
                            <h1 className="px-2 text-base">
                                <span className="font-bold">Total Pago:</span> {factura.fac_ven_total_pago}</h1>
                        </div>
                        <div className="items-end mt-4 text-gray-700">
                            <button className="bg-color1 rounded px-5 py-2"
                                    onClick={() => handleUpdateStatus(factura.Id_FacturaVenta)}>
                                Actualizar Entrega
                            </button>
                        </div>

                    </div>
                </div>
            ))}
        </div>
    );


    return (
        <div className="w-3/4 p-5 overflow-y-auto">
            {renderFacturas()}
        </div>
    )
}

export default FacturasView;