import React from "react";
import {Link} from "react-router-dom";

function Home() {
    return (
        <div className="min-h-screen flex justify-center items-center flex-col">
            <button className="w-64 flex justify-center rounded-md mb-4 p-3 bg-white hover:bg-color2 hover:text-black">
                <Link to="/gerente">
                    <span className="btm-nav-label">Gerente</span>
                </Link>
            </button>
            <button className="w-64 flex justify-center rounded-md mb-4 p-3 bg-white hover:bg-color2 hover:text-black">
                <Link to="/tendero">
                    <span className="btm-nav-label">Tendero</span>
                </Link>
            </button>
        </div>
    )
}

export default Home;