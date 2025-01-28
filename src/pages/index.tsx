import { lazy, Suspense } from "react";
import { Navigate, Outlet, Route, Routes } from "react-router";
import { ROUTES } from "../types";
import api from "../lib/api";
import { SjrProvider } from "../context";

const Login = lazy(() => import("./Login/Login"));
const Messages = lazy(() => import("./Messages/Messages"));
const Home = lazy(() => import("./Home/Home"));

const Pages = () => {
  const auth = () => api.isAuthenticated();

  return (
    <Suspense fallback={<div>Loading...</div>}>
      <Routes>
        <Route path={ROUTES.LOGIN} element={!auth() ? <Login /> : <Navigate to={ROUTES.HOME} />} />
        <Route
          path={ROUTES.HOME}
          element={auth() ? <SjrProvider><Outlet /></SjrProvider> : <Navigate to={ROUTES.LOGIN} />}
        >
          <Route index element={<Home />} />
          <Route path={ROUTES.MESSAGES} element={<Messages />} />
        </Route>


        {/* Redirect to Home if authenticated */}
        <Route
          path="/"
          element={<Navigate to={auth() ? ROUTES.HOME : ROUTES.LOGIN} />}
        />
      </Routes>
    </Suspense>
  )
};

export default Pages