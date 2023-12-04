import React from "react";
import {Link} from "react-router-dom";

function MenuTendero() {
    return (
        <aside className="relative w-1/4 bg-white p-5">
            <button className="w-full mb-4 p-3 rounded-md bg-color2  hover:bg-gray-400 hover:text-white">
                <Link to="/usuario">
                    <span className="btm-nav-label">Información Usuario</span>
                </Link>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2  hover:bg-gray-400 hover:text-white">
                <Link to="productos">
                    <span className="btm-nav-label">Productos en Existencia</span>
                </Link>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2  hover:bg-gray-400 hover:text-white">
                <Link to="facturasventas">
                    <span className="btm-nav-label">Ventas Registradas</span>
                </Link>
            </button>
            <div className="absolute w-full mb-4 p-3 bottom-0 left-0">
                <button className="w-full border-1 rounded-md text-black bg-opacity-60 bg-color1 mb-4 px-5 py-3 hover:bg-color1 hover:text-white">
                    <Link to="registrarventas">
                        <span className="text-black">Registrar venta</span>
                    </Link>
                </button>
            </div>
        </aside>
    )
}

export default MenuTendero;