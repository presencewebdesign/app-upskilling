import { FC, useState } from 'react';
import api from '../../lib/api';
import s from './Login.module.scss';

export interface LoginFormProps {
  callback?(): void;
}


const LoginForm: FC<LoginFormProps> = ({ callback = () => {} }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    try {
      await api.login(email, password);
      // Handle successful login, e.g., redirect to another page
      callback();
      window.location.reload();
    } catch (err) {
      setError((err as Error).message);
    }
  };

  return (
    <form className={s.form} onSubmit={handleSubmit}>
      <div className={s.formGroup}>
        <label className={s.label} htmlFor="email">Email:</label>
        <input
          className={s.input}
          type="email"
          id="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
      </div>
      <div className={s.formGroup}>
        <label className={s.label} htmlFor="password">Password:</label>
        <input
          className={s.input}
          type="password"
          id="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
      </div>
      <button type="submit">Continue</button>
      {error && <div>{error}</div>}
    </form>
  );
};

export default LoginForm;
