import {useEffect, useState} from "react";
import axios from "axios";
import {Field, Form, Formik} from "formik";

const RegistrarVenta = () => {

    const [clientes, setClientes] = useState([]);
    const [productos, setProductos] = useState([]);
    const [loading, setLoading] = useState(true);


    useEffect(() => {
        axios.get('http://localhost:3001/api/clientes')
            .then((response) => {
                setClientes(response.data);
                setLoading(false);
            })
            .catch((error) => {
                console.error('Error al obtener datos:', error);
                setLoading(false);
            });
        axios.get('http://localhost:3001/api/productosfactura')
            .then((response) => {
                setProductos(response.data);
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

    const handleAddProduct = (values, setValues) => {
        const newProduct = {
            idProducto: '',
            cantidad: '',
            precioUnitario: '',
            precioTotal: 0
        };

        setValues({
            ...values,
            productosform: [...values.productosform, newProduct]
        });
    };

    const handleSubmitRegistrar = (values) => {
        console.log('Form submit values:', values);
        axios.post('http://localhost:3001/api/registrarFacturaVenta', values)
            .then(response => {
                console.log(response.data);
            })
            .catch(error => {
                console.error('Error al registrar la factura:', error);
            });
    };


    return (
        <div className="flex justify-center w-3/4 p-5 overflow-y-auto">
            <div className="flex flex-col overflow-y-auto w-3/4 bg-color2 bg-opacity-60 rounded-md p-5">
                <div className="flex flex-col justify-center items-center">
                    <h1 className="text-xl font-bold">Distribuidor de Huevos del Mono</h1>
                    <h1 className="text-base font-semibold">Dirección Sucursal #a-b, nombre sede</h1>
                    <h1 className="text-base font-semibold">elmono@email.com</h1>
                    <h1 className="text-base font-semibold">Tel: xxx-xxxx</h1>
                </div>
                <Formik
                    initialValues={{
                        id_numero_identificacion: '',
                        nuevo_cliente: {
                            id_numero_identificacion: '',
                            cli_nombre: '',
                            cli_apellido: '',
                            cli_telefono: '',
                            cli_direccion: '',
                            cli_tipo_identificacion: '',
                            cli_ciudad: '',
                        },
                        fac_ven_descripcion: '',
                        fac_ven_estado_entrega: '',
                        fac_ven_metodo_pago: '',
                        fac_ven_modo_entrega: '',
                        fac_ven_total_pago: 0,
                        productosform: [{
                            idProducto: '',
                            cantidad: 0,
                            precioUnitario: 0,
                            precioTotal: 0
                        }],
                    }}
                    onSubmit={handleSubmitRegistrar}
                >
                    {({values, setValues, setFieldValue}) => (
                        <Form className="grid grid-cols-1 gap-6 mt-8 md:grid-cols-2">
                            <div className="col-span-2">
                                <label className="block mb-2 text-base text-black font-semibold">Seleccionar Cliente
                                    Existente</label>
                                <Field as="select"
                                       name='id_numero_identificacion'
                                       className="block w-full px-5 py-3 mt-2 text-gray-700 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40">
                                    <option value="">-- Seleccione un cliente --</option>
                                    {clientes?.map((cliente, index) => (
                                        <option key={index}
                                                value={cliente.id_numero_identificacion}>{cliente.id_numero_identificacion}</option>
                                    ))}
                                </Field>
                            </div>

                            <div className="col-span-2">
                                <h1 className="text-base font-bold">Datos Cliente Nuevo</h1>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Nombre
                                        Cliente</label>
                                    <Field
                                        type="text"
                                        id="nuevo_cliente.cli_nombre"
                                        name="nuevo_cliente.cli_nombre"
                                        placeholder="Nombre cliente"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Apellido
                                        Cliente</label>
                                    <Field
                                        type="text"
                                        id="nuevo_cliente.cli_apellido"
                                        name="nuevo_cliente.cli_apellido"
                                        placeholder="Apellido cliente"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <label className="block mb-2 text-base text-black font-semibold">No.
                                    Identificación</label>
                                <div className="flex">
                                    <Field
                                        as="select"
                                        id="nuevo_cliente.cli_tipo_identificacion"
                                        name="nuevo_cliente.cli_tipo_identificacion"
                                        placeholder="xxxxxxxxxx"
                                        className="block w-1/4 px-2 py-3 mt-2 mr-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    >
                                        <option value="">--</option>
                                        <option value="CC">CC</option>
                                        <option value="NIT">NIT</option>
                                        <option value="TI">TI</option>
                                    </Field>
                                    <Field
                                        type="number"
                                        id="nuevo_cliente.id_numero_identificacion"
                                        name="nuevo_cliente.id_numero_identificacion"
                                        placeholder="xxxxxxxxxx"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Teléfono
                                        Cliente</label>
                                    <Field
                                        type="number"
                                        id="nuevo_cliente.cli_telefono"
                                        name="nuevo_cliente.cli_telefono"
                                        placeholder="320XXXXXXX"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Dirección</label>
                                    <Field
                                        type="text"
                                        id="nuevo_cliente.cli_direccion"
                                        name="nuevo_cliente.cli_direccion"
                                        placeholder=""
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Ciudad de
                                        Residencia</label>
                                    <Field
                                        type="text"
                                        id="nuevo_cliente.cli_ciudad"
                                        name="nuevo_cliente.cli_ciudad"
                                        placeholder="Villavicencio"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div className="col-span-2">
                                <h1 className="text-base font-bold">Productos</h1>
                            </div>

                            {values.productosform.map((product, index) => (
                                <div key={index} className="flex flex-row col-span-2">
                                    <div>
                                        <label htmlFor={`productosform.${index}.idProducto`}
                                               className="block mb-2 text-base text-black font-semibold">
                                            Producto:
                                        </label>
                                        <Field
                                            as="select"
                                            id={`productosform.${index}.idProducto`}
                                            name={`productosform.${index}.idProducto`}
                                            className="w-full p-2 border border-gray-300 rounded"
                                        >
                                            <option value="">-- Producto --</option>
                                            {productos?.map((producto, index) => (
                                                <option key={index}
                                                        value={producto.Id_ProductoTienda}>{producto.pro_nombre}</option>
                                            ))}

                                        </Field>
                                    </div>
                                    <div className="mx-3">
                                        <label htmlFor={`productosform.${index}.cantidad`}
                                               className="block mb-2 text-base text-black font-semibold">
                                            Cantidad:
                                        </label>
                                        <Field
                                            type="number"
                                            id={`productosform.${index}.cantidad`}
                                            name={`productosform.${index}.cantidad`}
                                            className="w-full p-2 border border-gray-300 rounded"
                                            onChange={(e) => {
                                                setFieldValue(`productosform.${index}.cantidad`, e.target.value);
                                            }}
                                        />
                                    </div>
                                    <div>
                                        <label htmlFor={`productosform.${index}.precioUnitario`}
                                               className="block mb-2 text-base text-black font-semibold">
                                            Precio Unitario:
                                        </label>
                                        <Field
                                            type="number"
                                            id={`productosform.${index}.precioUnitario`}
                                            name={`productosform.${index}.precioUnitario`}
                                            className="w-full p-2 border border-gray-300 rounded"
                                            onChange={(e) => {
                                                setFieldValue(`productosform.${index}.precioUnitario`, e.target.value);
                                            }}
                                        />
                                    </div>
                                    <div className="ml-2">
                                        <label htmlFor={`productosform.${index}.precioTotal`}
                                               className="block mb-2 text-base text-black font-semibold">
                                            Precio Total:
                                        </label>
                                        <Field
                                            type="text"
                                            id={`productosform.${index}.precioTotal`}
                                            name={`productosform.${index}.precioTotal`}
                                            value={product.cantidad * product.precioUnitario}
                                            className="w-full p-2 border border-gray-300 rounded"
                                            readOnly
                                        />
                                    </div>
                                    {/* Agrega campos adicionales según tus necesidades */}
                                </div>

                            ))}

                            {/* Botón para agregar un nuevo producto */}
                            <button
                                type="button"
                                className="flex items-center justify-between w-2/3 px-6 py-3 text-base tracking-wide text-black capitalize transition-colors duration-300 transform bg-color1 rounded-lg hover:bg-blue-400 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
                                onClick={() => handleAddProduct(values, setValues)}
                            >
                                Agregar Producto
                            </button>

                            <div className="col-span-2">
                                <h1 className="text-base font-bold">Información Adicional</h1>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Método de
                                        pago</label>
                                    <Field
                                        as="select"
                                        id="fac_ven_metodo_pago"
                                        name="fac_ven_metodo_pago"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    >
                                        <option value="">-- Seleccione método pago --</option>
                                        <option value="movil">Movil</option>
                                        <option value="bancario">Bancario</option>
                                        <option value="efectivo">Efectivo</option>
                                    </Field>
                                </div>
                            </div>
                            <div className="flex">
                                <div className="mr-2">
                                    <label className="block mb-2 text-base text-black font-semibold">Modo
                                        entrega</label>
                                    <Field
                                        as="select"
                                        id="fac_ven_modo_entrega"
                                        name="fac_ven_modo_entrega"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    >
                                        <option value="">-- Seleccione modo entrega --</option>
                                        <option value="tienda">Tienda</option>
                                        <option value="domicilio">Domicilio</option>
                                    </Field>
                                </div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Entregado</label>
                                    <Field
                                        as="select"
                                        id="fac_ven_estado_entrega"
                                        name="fac_ven_estado_entrega"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    >
                                        <option value="">--</option>
                                        <option value="1">Si</option>
                                        <option value="0">No</option>
                                    </Field>
                                </div>
                            </div>

                            <div className="col-span-2">
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Descripción</label>
                                    <Field
                                        as="textarea"
                                        id="fac_ven_descripcion"
                                        name="fac_ven_descripcion"
                                        className="block w-full px-5 py-3 mt-2 h-32 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div className="mb-4 col-start-2">
                                <label htmlFor="fac_ven_total_pago" className="block text-sm font-semibold mb-2">
                                    Total General:
                                </label>
                                <Field
                                    type="text"
                                    id="fac_ven_total_pago"
                                    name="fac_ven_total_pago"
                                    value={values.productosform.reduce((total, product) => total + (product.cantidad * product.precioUnitario), 0)}
                                    className="w-full p-2 border border-gray-300 rounded"
                                    readOnly
                                />
                            </div>

                            <button
                                type="submit"
                                className="flex items-center justify-between w-2/3 px-5 py-3 text-base tracking-wide text-black capitalize bg-color1 rounded-lg focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
                                <span>Registrar Venta</span>
                            </button>
                        </Form>
                    )}
                </Formik>
            </div>
        </div>
    )
}

export default RegistrarVenta;