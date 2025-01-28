import api from "../../lib/api"
import { ROUTES, SJR } from "../../types"
import { useUserInfo } from "../../hooks"
import { LinkCollection } from "../../components"
import s from './Home.module.scss';
import { useSjrContext } from "../../context";
import { useNavigate } from "react-router";
import { useEffect } from "react";
import { installNativeAppFunctions } from "../../lib/nativeAppFunctions";

const Home = () => {
  const { userInfo, loading } = useUserInfo();
  const { checkFeatureAvailable } = useSjrContext();
  const navigate = useNavigate();

  useEffect(() => {
    installNativeAppFunctions(navigate);
  }, [navigate]);

  const getGreeting = () => {
    const now = new Date().getHours();
    if (now < 12)
      return "Good morning";
    if (now < 18)
      return "Good afternoon";
    return "Good evening";
  }

  if (loading)
    return <div>Loading...</div>;

  return (
    <div>
      <h1>
        {getGreeting()}, <br />
        {userInfo?.first_name} {userInfo?.last_name}
      </h1>
      <h2>NHS number: <span className={s.nhsNumber}>123 456 7890</span></h2>

      <LinkCollection 
        title={"Services"}
        url={ROUTES.SERVICES}
        links={[
          { label: "Request repeat prescriptions", url: ROUTES.MESSAGES },
          { label: "Check if you need urgent medical help using 111 online", url: ROUTES.MESSAGES },
          { label: "Find NHS services near you", url: ROUTES.MESSAGES }
        ]} 
      />
      {checkFeatureAvailable(SJR.HEALTH_RECORD) ? (
          <LinkCollection 
            title={"Your health"}
            url={ROUTES.SERVICES}
            links={[
              { label: "GP health record", url: ROUTES.MESSAGES },
              { label: "View and manage prescriptions", url: ROUTES.MESSAGES },
              { label: "Upcoming and past appointments", url: ROUTES.MESSAGES }
            ]} 
          />
      ) : <></>}
      <LinkCollection 
        title={"Messages"}
        links={[
          { label: "View your messages", url: ROUTES.MESSAGES },
        ]} 
      />

      <button onClick={() => api.logout()}>Logout</button>
    </div>
  )
}

export default Home