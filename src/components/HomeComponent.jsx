import Menu from "./MenuComponent";
import React from "react";
import {Route, Routes} from "react-router-dom";
import ProductsView from "../pages/ProductsPages";

function Home() {
    return (
        <div className="flex flex-row min-h-screen bg-color1">
            <Menu/>
            <Routes>
                <Route path="/products" element={<ProductsView/>}/>
            </Routes>
        </div>
    )
}

export default Home;