import { InputHTMLAttributes } from 'react';
import s from './FormField.module.scss';

interface FormFieldProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string;
  error?: string;
}

export const FormField: React.FC<FormFieldProps> = ({
  label,
  error,
  id,
  required,
  ...inputProps
}) => (
  <div className={s.formGroup}>
    <label className={s.label} htmlFor={id}>{label}</label>
    <input
      className={`${s.input} ${error ? s.inputError : ''}`}
      id={id}
      aria-required={required}
      aria-invalid={!!error}
      aria-describedby={error ? `${id}-error` : undefined}
      {...inputProps}
    />
    {error && (
      <span className={s.fieldError} id={`${id}-error`} role="alert">
        {error}
      </span>
    )}
  </div>
); 