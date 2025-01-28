import { NavigateFunction } from "react-router";
import { ROUTES } from "../types";

interface NativeAppFunctions {
  navigateToPage(tab: number): void;
}

declare global {
  interface Window {
    nativeAppFunctions: NativeAppFunctions;
  }
}

export const installNativeAppFunctions = (navigate: NavigateFunction) => {
  window.nativeAppFunctions = {
    navigateToPage(tab: number) {
      switch (tab) {
        case 0:
          navigate(ROUTES.HOME)
          break;
        case 1:
          navigate(ROUTES.SERVICES)
          break;
        case 2:
          navigate(ROUTES.MESSAGES)
          break;
        case 3:
          navigate(ROUTES.MESSAGES)
          break;
        default:
          navigate(ROUTES.HOME)
      }
    }
  }
}