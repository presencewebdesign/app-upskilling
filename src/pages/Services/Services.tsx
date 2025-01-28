import { ROUTES } from "../../types";
import ServiceSection from "../../components/ServiceSection/ServiceSection";
import s from "./Services.module.scss";

const Services = () => {
  const gpServices = [
    { title: "Request repeat prescriptions", route: ROUTES.MESSAGES },
    { title: "Check for available GP appointments", route: ROUTES.MESSAGES },
  ];

  const otherServices = [
    { title: "Check if you need urgent medical help using 111 online", route: ROUTES.MESSAGES },
    { title: "Request an emergency repeat prescription using 111 online", route: ROUTES.MESSAGES },
    { title: "Find NHS services near you", route: ROUTES.MESSAGES },
  ];

  const healthInfo = [
    { title: "Browse NHS health information", route: ROUTES.MESSAGES },
    { title: "Browse NHS medicines information", route: ROUTES.MESSAGES },
    { title: "Find COVID-19 guidance", route: ROUTES.MESSAGES },
  ];

  return (
    <div className={s.container}>
      <h1>Services</h1>
      <p className={s.subtitle}>Get care and support to help you stay well</p>

      <ServiceSection title="Your GP services" links={gpServices} />
      <ServiceSection title="Other NHS services" links={otherServices} />
      <ServiceSection title="Find health information" links={healthInfo} />
    </div>
  );
};

export default Services; 