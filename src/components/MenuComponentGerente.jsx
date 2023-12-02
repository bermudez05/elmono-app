import React from "react";
import {Link} from "react-router-dom";

function Menu() {
    return (
        <aside className="relative w-1/4 bg-white p-5">
            <div className="mb-4 p-3 bg-color2">
                Información usuario
            </div>
            <div className="mb-4 p-3 bg-color2">
                <Link to="productos">Productos existentes</Link>
            </div>
            <div className="mb-4 p-3 bg-color2">
                Historial de transacciones
            </div>
            <div className="absolute w-full mb-4 p-3 bottom-0 left-0">
                <button className="w-full border-1 opacity-70 bg-color1 border-gray-500 mb-4 px-5 py-3">
                    <span className="text-black opacity-100">Registrar venta</span>
                </button>
            </div>
        </aside>
    )
}

export default Menu;