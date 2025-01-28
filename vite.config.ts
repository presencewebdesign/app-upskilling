import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';
import { nodePolyfills } from 'vite-plugin-node-polyfills';

// https://vite.dev/config/
export default defineConfig(({ mode }) => {
  process.env = {...process.env, ...loadEnv(mode, process.cwd())};
  
  const API_BASE_URL = process.env.VITE_API_BASE_URL;
  
  return {
  plugins: [react(), nodePolyfills()],
  server: {
    proxy: {
      '/api': {  // The prefix for your API requests
        target: API_BASE_URL, // Your backend server URL (replace with your actual URL)
        changeOrigin: true,  // Usually needed for cross-origin requests
        rewrite: (path) => path.replace(/^\/api/, '') // Remove the '/api' prefix from the request URL
      }
      // You can add more proxies for different prefixes if needed
    },
    host: "0.0.0.0"
  }
}})
