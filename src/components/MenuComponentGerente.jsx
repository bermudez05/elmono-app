import React from "react";
import {Link} from "react-router-dom";

function Menu() {
    return (
        <aside className="relative w-1/4 bg-white p-5">
            <button className="w-full mb-4 p-3 rounded-md bg-color2">
                <Link to="/usuario">
                    <span className="btm-nav-label">Informacion Usuario</span>
                </Link>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2">
                <Link to="productos">
                    <span className="btm-nav-label">Productos existencia</span>
                </Link>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2">
                <Link to="/transacciones">
                    <span className="btm-nav-label">Historial transacciones</span>
                </Link>
            </button>

            <div className="absolute w-full mb-4 p-3 bottom-0 left-0">
                <button className="w-full border-1 opacity-70 rounded-md bg-color1 border-gray-500 mb-4 px-5 py-3">
                    <span className="text-black">Registrar gasto</span>
                </button>
                <button className="w-full border-1 opacity-70 rounded-md bg-color1 border-gray-500 mb-4 px-5 py-3">
                    <span className="text-black">Registrar compra</span>
                </button>
            </div>
        </aside>
    )
}

export default Menu;