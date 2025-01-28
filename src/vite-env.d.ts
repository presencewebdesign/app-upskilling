/// <reference types="vite/client" />

declare module "*.jpg" {
  const content: string;
  export default content;
}
