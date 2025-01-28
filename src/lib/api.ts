import { decode, JwtPayload } from 'jsonwebtoken';
import { Message, ServiceJourneyRule, User } from '../types';

class API {
  private token: string | null = null;
  private refreshToken: string | null = null;

  public getToken(): string | null {
    return this.token;
  }

  public getRefreshToken(): string | null {
    return this.refreshToken;
  }

  public setToken(token: string | null): void {
    this.token = token;
    if (token) {
      localStorage.setItem('token', token);
    } else {
      localStorage.removeItem('token');
    }
  }

  public setRefreshToken(refreshToken: string | null): void {
    this.refreshToken = refreshToken;
    if (refreshToken) {
      localStorage.setItem('refreshToken', refreshToken);
    } else {
      localStorage.removeItem('refreshToken');
    }
  }

  
  private loadTokenFromStorage(): void {
    const storedToken = localStorage.getItem('token');
    if (storedToken) {
      this.token = storedToken;
    }
  }

  private loadRefreshTokenFromStorage(): void {
    const storedRefreshToken = localStorage.getItem('refreshToken');
    if (storedRefreshToken) {
      this.refreshToken = storedRefreshToken;
    }
  }
  
  constructor(){
    this.loadTokenFromStorage();
    this.loadRefreshTokenFromStorage();
  }

  public isTokenExpired(token: string | null): boolean {
    if (!token) {
      return true; // Treat missing token as expired
    }

    try {
      const decodedToken: JwtPayload = decode(token) as JwtPayload;
      const expiry = decodedToken.exp;
      if (!expiry) {
        return false; // No expiry set - treat as valid if we've got this far
      }
      const now = Math.floor(Date.now() / 1000);  // Convert to seconds
      return now >= expiry;
    } catch (error) {
      console.error("Error decoding token to check expiry:", error);
      return true; // Treat decoding errors as expired
    }
  }

  public isAuthenticated(): boolean {
    this.loadTokenFromStorage();
    this.loadRefreshTokenFromStorage();
    return this.token !== null && !this.isTokenExpired(this.token);
  }


  public async login(email: string, password: string): Promise<string | null> {
    if (this.refreshToken || (this.token && this.isTokenExpired(this.token))) {
      const newAccessToken = await this.refreshAccessToken();
      if (newAccessToken) {
        return newAccessToken;
      } else {
        // Fall through to normal login if refresh fails. Consider clearing refresh token here.
        this.setRefreshToken(null);
      }

    } else if (this.token){
        return this.token;
    }

    // Regular login flow if no refresh token or refresh fails
    try {
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password })
      });

      if (!response.ok) {
        throw new Error(`HTTP error ${response.status}`);
      }

      const { data } = await response.json();
      const accessToken = data.access_token;
      const newRefreshToken = data.refresh_token;


      this.setToken(accessToken);
      this.setRefreshToken(newRefreshToken);


      return accessToken;

    } catch (error) {
      console.error("Error during login:", error);
      return null;
    }
  }

  public logout(): void {
    this.setToken(null);
    this.setRefreshToken(null);
    window.location.href = '/login';
  }

  public decodeToken(): ReturnType<typeof decode> | null{
    if (!this.token) {
      return null;
    }
    try {
      return decode(this.token);
    } catch (error) {
      console.error("Error decoding token:", error);
      return null;
    }
  }

  public async refreshAccessToken(): Promise<string | null> {
    if (!this.refreshToken) {
      console.warn("No refresh token available.");
      return null;
    }

    // Placeholder for your refresh token logic.  Replace with your actual implementation.
    try {
      const response = await fetch('/api/auth/refresh', { // Example endpoint, replace with your own
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ refreshToken: this.refreshToken }),
      });

      if (!response.ok) {
        throw new Error(`HTTP error ${response.status}`);
      }

      const { data } = await response.json();
      const newAccessToken = data.access_token; // Adjust based on your API response

      if (newAccessToken) {
        this.setToken(newAccessToken);
        return newAccessToken;
      } else {
        console.error("Refresh token request did not return a new access token.");
        // Consider logging out the user here as the refresh token might be invalid.
        return null;
      }

    } catch (error) {
      console.error("Error refreshing access token:", error);
      // Consider logging out the user here as the refresh might have failed.
      return null;
    }
  }

  async request<T>(url: string, options: RequestInit): Promise<T> {
    return fetch(url, { 
      ...options, 
      headers: { 
        ...options.headers, 
        Authorization: `Bearer ${this.token}`, 
        'Content-Type': 'application/json' 
      } 
    }).then(async (res) => {
        if (res.ok) {
        const { data } = await res.json();
        return data;
      } else {
        throw new Error(res.statusText);
      }
    });
  }

  public async getAllMessages(): Promise<Message[]> {
    return this.request<Message[]>(`/api/items/messages`, {
      method: 'GET',
    });
  }

  public async getMessage(id: string): Promise<Message> {
    return this.request<Message>(`/api/items/messages/${id}`, {
      method: 'GET',
    });
  }

  public async getUsersMe() {
    return this.request<User>(`/api/users/me`, {
      method: 'GET',
    });
  }
  
  public async getServiceJourneyRules() {
    return this.request<ServiceJourneyRule[]>(`/api/items/sjr`, {
      method: 'GET',
    });
  }
}


export default new API();
