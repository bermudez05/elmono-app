import React from "react";
import {Link} from "react-router-dom";

function Home() {
    return (
        <div className="min-h-screen flex justify-center items-center flex-col">
            <div className="w-64 flex justify-center rounded-md shadow-md mb-4 p-3 bg-color2">
                <Link to="/gerente">Gerente</Link>
            </div>
            <div className="w-64 flex justify-center rounded-md shadow-md mb-4 p-3 bg-color2">
                <Link to="/tendero">Tendero</Link>
            </div>
        </div>
    )
}

export default Home;