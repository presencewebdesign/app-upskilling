import { useState } from "react";
import { validateLoginForm, type ValidationError } from "../utils/validation";
import api from "../lib/api";

interface UseLoginFormProps {
  onSuccess(): void;
}

interface UseLoginFormReturn {
  email: string;
  password: string;
  error: string;
  isLoading: boolean;
  validationErrors: ValidationError;
  handleEmailChange(e: React.ChangeEvent<HTMLInputElement>): void;
  handlePasswordChange(e: React.ChangeEvent<HTMLInputElement>): void;
  handleSubmit(e: React.FormEvent): Promise<void>;
}

export const useLoginForm = ({ onSuccess }: UseLoginFormProps): UseLoginFormReturn => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [validationErrors, setValidationErrors] = useState<ValidationError>({
    email: "",
    password: ""
  });

  const clearFieldError = (field: keyof ValidationError) => {
    setValidationErrors((prev) => ({
      ...prev,
      [field]: ""
    }));
    // Clear the main error message when user starts typing
    setError("");
  };

  const handleEmailChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setEmail(e.target.value);
    clearFieldError("email");
  };

  const handlePasswordChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setPassword(e.target.value);
    clearFieldError("password");
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    const errors = validateLoginForm(email, password);
    setValidationErrors(errors);

    if (errors.email || errors.password) {
      return;
    }

    setIsLoading(true);
    try {
      const response = await api.login(email, password);
      if (!response) {
        setError("Invalid email or password. Please try again.");
        return;
      }
      onSuccess();
    } catch (err) {
      // Handle specific error cases
      if ((err as Error).message.includes("401")) {
        setError("Invalid email or password. Please try again.");
      } else if ((err as Error).message.includes("429")) {
        setError("Too many login attempts. Please try again later.");
      } else {
        setError("An error occurred while signing in. Please try again.");
      }
    } finally {
      setIsLoading(false);
    }
  };

  return {
    email,
    password,
    error,
    isLoading,
    validationErrors,
    handleEmailChange,
    handlePasswordChange,
    handleSubmit
  };
};
