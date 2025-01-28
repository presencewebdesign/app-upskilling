import { Link } from 'react-router';
import { ROUTES } from '../../types';
import s from './LinkCollection.module.scss';

interface LinkCollectionProps {
  title: string;
  url?: ROUTES;
  links: { label: string; url: ROUTES }[];
}

const LinkCollection: React.FC<LinkCollectionProps> = ({ links, title, url }) => {
  return (
    <div>
      <div className={s.header}>
        <h3>{title}</h3>
        {url && <Link to={url}>View all</Link>}
      </div>
      <div className={s.linkCollection}>
        {links.map((link, index) => (
          <div key={index} className={s.link}>
            <Link to={link.url}>
              {link.label}
              <span className={s.chevron}></span>
            </Link>
            {index < links.length - 1 && <hr />}
          </div>
        ))}
      </div>
    </div>
  );
};

export default LinkCollection;
