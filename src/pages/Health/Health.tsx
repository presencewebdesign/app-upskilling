import { Link } from "react-router";
import { ROUTES } from "../../types";

const Health = () => {
  return (
    <div>
      <h1>Health</h1>
      <Link to={ROUTES.HOME}>Home</Link>
    </div>
  )
}

export default Health; 