import { useEffect, useState } from 'react';
import api from '../lib/api';
import { User } from '../types';

const useUserInfo = () => {
  const [userInfo, setUserInfo] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [refetch, setRefetch] = useState(false);

  useEffect(() => {
    const fetchUserInfo = async () => {
      try {
        const data = await api.getUsersMe();
        setUserInfo(data);
      } catch (err) {
        setError((err as Error).message);
      } finally {
        setLoading(false);
      }
    };

    if (api.isAuthenticated()) {
      fetchUserInfo();
    } else {
      setLoading(false);
    }
  }, [refetch]);

  return { userInfo, loading, error, refetchData: () => setRefetch(!refetch) };
};

export default useUserInfo;
