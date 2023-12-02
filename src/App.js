import './App.css';
import {BrowserRouter, Navigate, Route, Routes} from "react-router-dom";
import Home from "./components/HomeComponent";
import GerentePage from "./pages/GerentePage";
import React from "react";
import ProductsView from "./pages/ProductsPages";
import TenderoPage from "./pages/TenderoPage";
import FacturasView from "./pages/FacturasPage";

function App() {
    return (
        <BrowserRouter>
            <div className="bg-color1">
                <Routes>
                    <Route path="*" element={<Navigate to="/" replace/>}/>
                    <Route path="/" element={<Home/>}/>
                    <Route path="/gerente" element={<GerentePage/>}>
                        <Route path={"productos"} element={<ProductsView/>}/>
                    </Route>
                    <Route path="/tendero" element={<TenderoPage/>}>
                        <Route path={"productos"} element={<ProductsView/>}/>
                        <Route path={"facturasventas"} element={<FacturasView/>}/>
                    </Route>
                </Routes>
            </div>
        </BrowserRouter>
    );
}

export default App;
