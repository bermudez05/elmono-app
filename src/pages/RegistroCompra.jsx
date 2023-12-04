import {useEffect, useState} from "react";
import axios from "axios";
import { Formik, Form, Field, ErrorMessage } from 'formik';

function RegistroCompra() {

    const [sucursal1, setSucursal1] = useState([])
    const [proveedor, setProveedor] = useState([]);
    const [productos, setProductos] = useState([]);
    const [loading, setLoading] = useState(true);


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
        axios.get('http://localhost:3001/api/proveedor')
            .then((response) => {
                setProveedor(response.data);
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
        console.log('Form submit values:', values)
    };

    const handleProductChange = (values, setValues, index) => {
        const cantidad = values.productosform[index].cantidad;
        const precioUnitario = values.productosform[index].precioUnitario;

        // Calcula el precio total del producto
        const precioTotal = cantidad * precioUnitario;

        // Actualiza el estado con el nuevo precio total del producto
        setValues((prevState) => {
            const updatedProducts = [...prevState.productosform];
            updatedProducts[index] = {...updatedProducts[index], precioTotal};
            const totalGeneral = updatedProducts.reduce(
                (total, product) => total + (product.precioTotal || 0),
                0
            );
            return {...prevState, productosform: updatedProducts, fac_ven_total_pago: totalGeneral};
        });
    };

    return(
        <div className="flex flex-col w-3/4 h-full items-center justify-center bg-color1 overflow-y-auto">
            <div className="flex flex-col p-5 w-4/6 h-5/6 rounded-md bg-color2 bg-opacity-60 overflow-y-auto">
            <h3 className="text-center text-base font-bold">Distribuidora de huevos el mono</h3>
            {sucursal1.map((sucursal) => (
                <div key={sucursal.Id_Sucursal}>
                    <p className="text-center text-base font-bold">{sucursal.suc_direccion},{sucursal.suc_ciudad} - {sucursal.suc_nombre}</p>
                    <p className="text-center text-base font-bold">{sucursal.suc_correo} - {sucursal.suc_telefono}</p>
                </div>
            ))}
            <Formik
                    initialValues={{
                        id_numero_identificacion: '',
                        nuevo_proveedor: {
                            id_numero_identificacion: '',
                            pro_nombre: '',
                            pro_telefono: '',
                            pro_direccion: '',
                        },
                        fac_com_descripcion: '',
                        fac_com_estado_entrega: '',
                        fac_com_metodo_pago: '',
                        fac_com_modo_entrega: '',
                        fac_com_total_pago: 0,
                        productosform: [{
                            idProducto: '',
                            cantidad: '',
                            precioUnitario: '',
                            precioTotal: 0
                        }],
                    }}
                    onSubmit={handleSubmitRegistrar}
                >
                    {({values, setValues, setFieldValue}) => (
                        <Form className="grid grid-cols-1 gap-6 mt-8 md:grid-cols-2">
                            <div className="col-span-2">
                                <label className="block mb-2 text-base text-black font-semibold">Seleccionar Proveedor
                                    Existente</label>
                                <Field as="select"
                                       name='id_numero_identificacion'
                                       className="block w-full px-5 py-3 mt-2 text-gray-700 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40">
                                    <option value="">-- Seleccione un Proveedor --</option>
                                    {proveedor?.map((proveedor, index) => (
                                        <option key={index}
                                                value={proveedor.id_numero_identificacion}>{proveedor.id_numero_identificacion}</option>
                                    ))}
                                </Field>
                            </div>

                            <div className="col-span-2">
                                <h1 className="text-base font-bold">Datos Proveedor Nuevo</h1>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Nombre
                                        Proveedor</label>
                                    <Field
                                        type="text"
                                        id="nuevo_proveedor.pro_nombre"
                                        name="nuevo_proveedor.pro_nombre"
                                        placeholder="Nombre proveedor"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <label className="block mb-2 text-base text-black font-semibold">No.
                                    Identificación</label>
                                <div className="flex">
                                    <Field
                                        type="number"
                                        id="nuevo_proveedor.id_numero_identificacion"
                                        name="nuevo_proveedor.id_numero_identificacion"
                                        placeholder="xxxxxxxxxx"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Teléfono
                                        Proveedor</label>
                                    <Field
                                        type="number"
                                        id="nuevo_proveedor.pro_telefono"
                                        name="nuevo_proveedor.pro_telefono"
                                        placeholder="320XXXXXXX"
                                        className="block w-full px-5 py-3 mt-2 text-gray-700 placeholder-gray-400 bg-white border border-gray-200 rounded-lg focus:border-blue-400 focus:ring-blue-400 focus:outline-none focus:ring focus:ring-opacity-40"
                                    />
                                </div>
                            </div>

                            <div>
                                <div>
                                    <label className="block mb-2 text-base text-black font-semibold">Dirección del proveedor</label>
                                    <Field
                                        type="text"
                                        id="nuevo_proveedor.pro_direccion"
                                        name="nuevo_proveedor.pro_direccion"
                                        placeholder="Calle XXXX"
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
                                            <option value="">-- Seleccione el Producto --</option>
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
                                    <div>
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
                                className="flex border-2 border-gray-200 items-center justify-between w-2/3 px-6 py-3 text-base tracking-wide text-black capitalize transition-colors duration-300 transform bg-color1 rounded-lg hover:bg-blue-400 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
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
                                        <option value="tienda">Si</option>
                                        <option value="domicilio">No</option>
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

                            <div className="mb-4 col-span-1 col-start-2">
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
                                className="flex border-2 border-gray-200 items-center justify-between w-2/3 px-5 py-3 text-base tracking-wide text-black capitalize bg-color1 rounded-lg focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
                                <span>Registrar Venta</span>
                            </button>
                        </Form>
                    )}
                </Formik>
            </div>
        </div>
    );
}

export default RegistroCompra;