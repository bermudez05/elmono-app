import {Outlet} from "react-router-dom";
import MenuTendero from "../components/MenuComponentTendero";

function TenderoPage() {
    return (
        <div className="flex h-screen overflow-hidden flex-row">
            <MenuTendero/>
            <Outlet/>
        </div>
    )
}

export default TenderoPage;