import React, { createContext, useEffect, useState } from 'react';
import api from '../lib/api';
import { ServiceJourneyRule, SJR } from '../types';

export interface SjrContextValue {
  loading: boolean;
  error: string | null;
  refetchData(): void;
  checkFeatureAvailable(rule: SJR): boolean;
}

export const SjrContext = createContext<SjrContextValue>({
  loading: true,
  error: null,
  refetchData: function (): void {
    throw new Error('Function not implemented.');
  },
  checkFeatureAvailable: function (): boolean {
    throw new Error('Function not implemented.');
  }
});

export const SjrProvider: React.FC<React.PropsWithChildren> = ({ children }) => {
  const [rules, setRules] = useState<ServiceJourneyRule[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [refetch, setRefetch] = useState(false);

  useEffect(() => {
    api.getServiceJourneyRules()
      .then(data => setRules(data))
      .catch(err => setError((err as Error).message))
      .finally(() => {
        setLoading(false);
        setRefetch(false);
      })
  }, [refetch]);

  const checkFeatureAvailable = (rule: SJR): boolean => {
    console.log('rule :>> ', rule);
    console.log('rules :>> ', rules);
    return rules.findIndex(r => r.machine_name === rule) > -1;
  }

  return (
    <SjrContext.Provider value={{ checkFeatureAvailable, loading, error, refetchData: () => setRefetch(true) }}>
      {children}
    </SjrContext.Provider>
  );
};
