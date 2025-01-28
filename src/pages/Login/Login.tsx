import { useNavigate } from "react-router";
import { LoginForm } from "../../forms";
import { ROUTES } from "../../types";

const Login = (): JSX.Element => {
  const navigate = useNavigate();
  return (
    <div>
      <h1>Login</h1>
      <LoginForm callback={() => navigate(ROUTES.HOME)} />
    </div>
  )
}

export default Login;
