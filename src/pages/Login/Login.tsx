import { useNavigate } from "react-router";
import { LoginForm } from "../../forms";
import { ROUTES } from "../../types";
import s from './Login.module.scss';

const Login = (): JSX.Element => {
  const navigate = useNavigate();
  return (
    <div className={s.loginPage}>
      <LoginForm callback={() => navigate(ROUTES.HOME)} />
    </div>
  );
};

export default Login;
