import { FC } from 'react';
import styles from './HelpChangeNhs.module.scss';

export const HelpChangeNhs: FC = () => {
  return (
    <div 
      className={styles.helpChangeNhs}
      onClick={() => window.open('https://www.nhsapp.service.nhs.uk/patient/redirector/help-change-the-nhs', '_blank')}
      role="button"
      tabIndex={0}
    >
      <img 
        src="/help-change-the-nhs.jpg" 
        alt="NHS staff member high-fiving a patient" 
        className={styles.image}
      />
      <div className={styles.content}>
        <h3>Help change the NHS</h3>
        <p>Have your say on making the NHS fit for the future</p>
      </div>
    </div>
  );
}; 