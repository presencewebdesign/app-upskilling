import { Link } from "react-router";
import { ROUTES } from "../../types";
import s from "./ServiceSection.module.scss";

interface ServiceLink {
  title: string;
  route: ROUTES;
}

interface ServiceSectionProps {
  title: string;
  links: ServiceLink[];
}

const ServiceSection: React.FC<ServiceSectionProps> = ({ title, links }) => {
  return (
    <div className={s.section}>
      <h2>{title}</h2>
      <div className={s.linkContainer}>
        {links.map((link, index) => (
          <Link key={index} to={link.route} className={s.link}>
            <span>{link.title}</span>
            <span className={s.chevron}>›</span>
          </Link>
        ))}
      </div>
    </div>
  );
};

export default ServiceSection; 