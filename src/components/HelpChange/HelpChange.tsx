import { FC } from 'react';
import styles from './HelpChange.module.scss';

export const HelpChange: FC = () => {
  return (
    <div 
      className={styles.helpChange}
      onClick={() => window.open('https://www.carehome.co.uk/', '_blank')}
      role="button"
      tabIndex={0}
    >
      <img 
        src="/help-change-the-nhs.jpg" 
        alt="staff member high-fiving a patient" 
        className={styles.image}
      />
      <div className={styles.content}>
        <h3>Help</h3>
        <p>Have your say on making us fit for the future</p>
      </div>
    </div>
  );
}; 