import { FC } from 'react';
import { FormField } from '../../components/FormField/FormField';
import { useLoginForm } from '../../hooks/useLoginForm';
import s from './Login.module.scss';

export interface LoginFormProps {
  callback?(): void;
}

const LoginForm: FC<LoginFormProps> = ({ callback = () => {} }) => {
  const {
    email,
    password,
    error,
    isLoading,
    validationErrors,
    handleEmailChange,
    handlePasswordChange,
    handleSubmit
  } = useLoginForm({
    onSuccess: () => {
      callback();
      window.location.reload();
    }
  });

  return (
    <div className={s.loginContainer}>
      <div className={s.formWrapper}>
        <h2>Sign in to NHS App</h2>
        <p className={s.subtitle}>Enter your email and password to continue</p>
        
        <form className={s.form} onSubmit={handleSubmit} noValidate>
          <FormField
            label="Email address"
            type="email"
            id="email"
            value={email}
            onChange={handleEmailChange}
            placeholder="Enter your email"
            required
            error={validationErrors.email}
          />

          <FormField
            label="Password"
            type="password"
            id="password"
            value={password}
            onChange={handlePasswordChange}
            placeholder="Enter your password"
            required
            error={validationErrors.password}
          />

          {error && <div className={s.error} role="alert">{error}</div>}

          <button 
            type="submit" 
            className={s.submitButton} 
            disabled={isLoading}
          >
            {isLoading ? (
              <span className={s.buttonContent}>
                <span className={s.spinner} aria-hidden="true" />
                <span className={s.buttonText}>Signing in...</span>
              </span>
            ) : (
              'Sign in'
            )}
          </button>
        </form>
      </div>
    </div>
  );
};

export default LoginForm;
