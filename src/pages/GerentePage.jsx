import Menu from "../components/MenuComponentGerente";
import {Outlet} from "react-router-dom";

function GerentePage() {
    return (
        <div className="flex flex-row min-h-screen">
            <Menu/>
            <Outlet/>
        </div>
    )
}

export default GerentePage;