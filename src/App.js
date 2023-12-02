import './App.css';
import {BrowserRouter, Navigate, Route, Routes} from "react-router-dom";
import Home from "./components/HomeComponent";
import GerentePage from "./pages/GerentePage";
import React from "react";
import ProductsView from "./pages/ProductsPages";

function App() {
    return (
        <BrowserRouter>
            <div className="bg-color1 min-h-screen border-2 border-black">
                <Routes>
                    <Route path="*" element={<Navigate to="/" replace/>}/>
                    <Route path="/" element={<Home/>}/>
                    <Route path="/gerente" element={<GerentePage/>}>
                        <Route path={"productos"} element={<ProductsView/>}/>
                    </Route>
                </Routes>
            </div>
        </BrowserRouter>
    );
}

export default App;
