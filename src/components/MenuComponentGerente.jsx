import React from "react";
import {Link} from "react-router-dom";

function Menu() {
    return (
        <aside className="relative w-1/4 bg-white p-5">
            <button className="w-full mb-4 p-3 rounded-md bg-color2  hover:bg-gray-400 hover:text-white">
                <a>
                    <span className="btm-nav-label">Informacion Usuario</span>
                </a>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2 hover:bg-gray-400 hover:text-white">
                <Link to="productos">
                    <span className="btm-nav-label">Productos existencia</span>
                </Link>
            </button>
            <button className="w-full mb-4 p-3 rounded-md bg-color2  hover:bg-gray-400 hover:text-white">
                <a>
                    <span className="btm-nav-label">Historial transacciones</span>
                </a>
            </button>

            <div className="absolute w-full mb-4 p-3 bottom-0 left-0">
                <button className="w-full border-1 rounded-md text-black bg-opacity-60 bg-color1 mb-4 px-5 py-3 hover:bg-color1 hover:text-white">
                    <span className="btm-nav-label">Registrar gasto</span>
                </button>
                <button className="w-full border-1 rounded-md text-black bg-opacity-60 bg-color1 mb-4 px-5 py-3 hover:bg-color1 hover:text-white">
                    <span className="btm-nav-label">Registrar compra</span>
                </button>
            </div>
        </aside>
    )
}

export default Menu;