import api from "../../lib/api"
import { ROUTES, SJR } from "../../types"
import { useUserInfo } from "../../hooks"
import { ServiceSection, HelpChangeNhs } from "../../components"
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

  const services = [
    { title: "Request repeat prescriptions", route: ROUTES.MESSAGES },
    { title: "Check if you need urgent medical help using 111 online", route: ROUTES.MESSAGES },
    { title: "Find NHS services near you", route: ROUTES.MESSAGES }
  ];

  const healthLinks = [
    { title: "GP health record", route: ROUTES.MESSAGES },
    { title: "View and manage prescriptions", route: ROUTES.MESSAGES },
    { title: "Upcoming and past appointments", route: ROUTES.MESSAGES }
  ];

  const messages = [
    { title: "View your messages", route: ROUTES.MESSAGES }
  ];

  const account = [
    { title: "Manage health services for others", route: ROUTES.MESSAGES }
  ];

  if (loading)
    return <div>Loading...</div>;

  return (
    <div className={s.container}>
      <header className={s.header}>
        <h1>
          {getGreeting()},<br />
          {userInfo?.first_name} {userInfo?.last_name}
        </h1>
        <h2>NHS number: <span className={s.nhsNumber}>432 270 2821</span></h2>
      </header>

      <ServiceSection title="Services" links={services} />
      
      {checkFeatureAvailable(SJR.HEALTH_RECORD) && (
        <ServiceSection title="Your health" links={healthLinks} />
      )}
      
      <ServiceSection title="Messages" links={messages} />
      <ServiceSection title="Account" links={account} />

      <HelpChangeNhs />

      <button onClick={() => api.logout()} className={s.logoutButton}>Logout</button>
    </div>
  )
}

export default Home