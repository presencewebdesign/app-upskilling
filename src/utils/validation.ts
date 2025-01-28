export const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export interface ValidationError {
  email: string;
  password: string;
}

export const validateLoginForm = (email: string, password: string): ValidationError => {
  const errors: ValidationError = {
    email: "",
    password: ""
  };

  // Email validation
  if (!email) {
    errors.email = "Email is required";
  } else if (!validateEmail(email)) {
    errors.email = "Please enter a valid email address";
  }

  // Password validation
  if (!password) {
    errors.password = "Password is required";
  }

  return errors;
};
